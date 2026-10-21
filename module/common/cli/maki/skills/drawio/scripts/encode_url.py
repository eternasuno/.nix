#!/usr/bin/env python3

import base64
import json
import sys
import urllib.parse
import xml.etree.ElementTree as ET
import zlib
from pathlib import Path


def validate(xml):
    if "<!DOCTYPE" in xml or "<!ENTITY" in xml or "<!--" in xml:
        raise ValueError("DTD, entity declarations, and XML comments are not supported")

    document = ET.fromstring(xml)
    if document.tag == "mxGraphModel":
        models = [document]
    elif document.tag == "mxfile":
        pages = list(document)
        if not pages or any(page.tag != "diagram" for page in pages):
            raise ValueError("mxfile must contain diagram pages")

        models = []
        for page in pages:
            if len(page) != 1 or page[0].tag != "mxGraphModel":
                raise ValueError("each page must contain one uncompressed mxGraphModel")

            models.append(page[0])
    else:
        raise ValueError("expected mxGraphModel or mxfile")

    for model in models:
        roots = model.findall("root")
        if len(roots) != 1 or len(model) != 1:
            raise ValueError("each graph must contain only one root")

        cells = {}
        for entry in roots[0]:
            if entry.tag == "mxCell":
                cell = entry
                identity = cell.get("id")
            elif entry.tag in ("UserObject", "object") and len(entry) == 1 and entry[0].tag == "mxCell":
                cell = entry[0]
                identity = entry.get("id") or cell.get("id")
                if entry.get("id") and cell.get("id") and entry.get("id") != cell.get("id"):
                    raise ValueError("wrapper and cell IDs conflict")
            else:
                raise ValueError("root children must be cells or single-cell object wrappers")

            if any(child.tag == "mxCell" for child in cell.iter() if child is not cell):
                raise ValueError("nested mxCell is not supported")

            if not identity or identity in cells:
                raise ValueError("cell IDs must be nonempty and unique within each page")

            cells[identity] = cell

        if "0" not in cells or "1" not in cells:
            raise ValueError("root cells 0 and 1 are required")

        if cells["0"].get("parent") is not None or cells["1"].get("parent") != "0":
            raise ValueError("invalid root parent chain")

        for identity, cell in cells.items():
            if identity != "0" and cell.get("parent") not in cells:
                raise ValueError(f"cell {identity}: missing or invalid parent")

            for attribute in ("source", "target"):
                reference = cell.get(attribute)
                if reference is not None and reference not in cells:
                    raise ValueError(f"cell {identity}: invalid {attribute} reference")

            visited = set()
            current = identity
            while current is not None:
                if current in visited:
                    raise ValueError(f"cell {identity}: parent cycle")

                visited.add(current)
                current = cells[current].get("parent")
                if current is not None and current not in cells:
                    raise ValueError(f"cell {identity}: invalid ancestor")

            if cell.get("edge") == "1":
                geometry = cell.findall("mxGeometry")
                if len(geometry) != 1 or geometry[0].get("relative") != "1" or geometry[0].get("as") != "geometry":
                    raise ValueError(f"edge {identity}: requires one relative mxGeometry child")



def encode_url(xml):
    validate(xml)
    encoded = urllib.parse.quote(xml, safe="~()*!.'-").encode("ascii")
    compressor = zlib.compressobj(wbits=-15)
    compressed = compressor.compress(encoded) + compressor.flush()
    payload = json.dumps({
        "type": "xml",
        "compressed": True,
        "data": base64.b64encode(compressed).decode("ascii"),
    }, separators=(",", ":"))

    return "https://app.diagrams.net/?grid=0&pv=0&border=10&edit=_blank#create=" + urllib.parse.quote(payload, safe="~()*!.'-")


def main():
    if len(sys.argv) > 2:
        print("usage: encode_url.py [file.drawio]", file=sys.stderr)

        return 2

    try:
        xml = Path(sys.argv[1]).read_text(encoding="utf-8") if len(sys.argv) == 2 else sys.stdin.read()
        url = encode_url(xml)
    except (OSError, UnicodeError, ET.ParseError, ValueError) as error:
        print(f"error: {error}", file=sys.stderr)

        return 1

    print(url)

    return 0


if __name__ == "__main__":
    sys.exit(main())
