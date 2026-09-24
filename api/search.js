import { searchDictionary } from "../lib/dictionary.js";
export default function handler(req,res) {
  res.setHeader("Cache-Control","public, max-age=0, s-maxage=60");
  if (req.method !== "GET") return res.status(405).json({error:"Method not allowed"});
  const q = typeof req.query.q === "string" ? req.query.q.slice(0,100) : "";
  if (!q.trim()) return res.status(400).json({error:"Missing query parameter q"});
  return res.status(200).json({query:q,results:searchDictionary(q,req.query.limit),sourceStatus:"demo-only"});
}
