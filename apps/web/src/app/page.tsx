async function getHealth() {
  const base = process.env.NEXT_PUBLIC_API_URL || "http://localhost:8000";
  try {
    const res = await fetch(`${base}/health`, { cache: "no-store" });
    if (!res.ok) return { ok: false, status: res.status };
    return await res.json();
  } catch {
    return { ok: false, error: "Could not reach API" };
  }
}

export default async function Home() {
  const health = await getHealth();

  return (
    <main style={{ padding: 24, maxWidth: 900 }}>
      <h1 style={{ marginTop: 0 }}>RetroBoard Starter</h1>

      <section style={{ padding: 16, border: "1px solid #ddd", borderRadius: 12 }}>
        <h2 style={{ marginTop: 0 }}>API Health</h2>
        <pre style={{ background: "#f6f6f6", padding: 12, borderRadius: 8, overflowX: "auto" }}>
          {JSON.stringify(health, null, 2)}
        </pre>
        <p style={{ marginBottom: 0 }}>
          Next: build <b>workspaces</b>, then <b>boards/lists/cards</b>, then <b>WebSockets</b>.
        </p>
      </section>
    </main>
  );
}
