#!/usr/bin/env node
import { readFile, writeFile } from "node:fs/promises";

const endpointId = process.argv[2];
const prompt = process.argv[3] ?? [
  "Luxury Instagram feed post advertisement for a beauty parlor offering bridal makeup.",
  "Format: 3:4 portrait social media post.",
  "Create an elegant Indian bridal beauty creative with a confident bride model in a red and gold bridal lehenga, gold jewelry, and premium salon vanity setting.",
  "Include clean readable text blocks exactly as: \"BEAUTY PARLOR\", \"BRIDAL MAKEUP\", \"Book Your Bridal Glow\", \"HD Makeup | Hair Styling | Saree Draping\", \"Limited Wedding Slots\", \"DM TO BOOK\"."
].join(" ");

if (!endpointId) {
  console.error("Usage: node submit-smoke-test.mjs <endpoint-id> [prompt]");
  process.exit(2);
}

const apiKey = process.env.RUNPOD_API_KEY;
if (!apiKey) {
  console.error("RUNPOD_API_KEY is required.");
  process.exit(2);
}

const workflow = JSON.parse(await readFile(new URL("./api-workflow.json", import.meta.url), "utf8"));

workflow["134:115"].inputs.value = prompt;
workflow["98:18"].inputs.noise_seed = Math.floor(Math.random() * Number.MAX_SAFE_INTEGER);

const response = await fetch(`https://api.runpod.ai/v2/${endpointId}/runsync`, {
  method: "POST",
  headers: {
    "Authorization": `Bearer ${apiKey}`,
    "Content-Type": "application/json"
  },
  body: JSON.stringify({
    input: {
      workflow
    }
  })
});

const body = await response.text();
await writeFile(new URL("./endpoint-smoke-response.json", import.meta.url), body);

console.log(`HTTP ${response.status}`);
console.log(body);

if (!response.ok) {
  process.exit(1);
}
