#!/usr/bin/env node
// encode_url.mjs — draw.io XML → app.diagrams.net editor URL. Zero deps (node built-ins only).
// Usage: node encode_url.mjs [file.drawio]   (reads stdin if no file given)
// Prints the URL to stdout; sanity warnings to stderr. Never opens a browser.

import fs from "node:fs";
import zlib from "node:zlib";

const file = process.argv[2];
const xml = file ? fs.readFileSync(file, "utf8") : fs.readFileSync(0, "utf8");

// Sanity checks — warn only, never block output (the editor is the final validator).
if (xml.includes("<!--")) {
  console.error("warn: XML contains <!-- comments -->; draw.io renders them oddly, remove them");
}
if (!/id="0"/.test(xml) || !/id="1"/.test(xml)) {
  console.error('warn: root cells id="0" / id="1" (parent chain) missing; diagram may not load');
}
if (/edge="1"/.test(xml) && !/mxGeometry relative="1"/.test(xml)) {
  console.error('warn: edges present but no <mxGeometry relative="1" as="geometry"/> found; every edge needs one');
}

// URL format identical to jgraph drawio-mcp: encodeURIComponent first (CJK-safe),
// then deflateRaw (RFC 1951), base64, wrapped in {type,compressed,data}, then
// encodeURIComponent again for the fragment.
const compressed = zlib.deflateRawSync(encodeURIComponent(xml)).toString("base64");
const payload = encodeURIComponent(JSON.stringify({ type: "xml", compressed: true, data: compressed }));
console.log("https://app.diagrams.net/?grid=0&pv=0&border=10&edit=_blank#create=" + payload);
