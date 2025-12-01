const express = require("express");
const pool = require("./db");

const app = express();
const PORT = process.env.API_PORT || 3000;

app.use(express.json());

app.get("/status", (_req, res) => {
  res.json({ status: "OK" });
});

app.get("/items", async (_req, res) => {
  try {
    const result = await pool.query("SELECT id, label FROM items ORDER BY id;");
    res.json(result.rows);
  } catch (err) {
    console.error("Error fetching items:", err);
    res.status(500).json({ error: "Internal server error" });
  }
});

app.listen(PORT, () => {
  console.log(`API listening on port ${PORT}`);
});
