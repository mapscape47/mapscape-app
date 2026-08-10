export async function GET() {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!;
  const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY!;

  // Hits the Auth health endpoint directly so this proves an actual
  // network round-trip to the project, not just that the client library
  // constructed without throwing. Doesn't require any tables to exist.
  const res = await fetch(`${supabaseUrl}/auth/v1/health`, {
    headers: { apikey: supabaseKey },
  });

  if (!res.ok) {
    return Response.json(
      { connected: false, status: res.status, error: await res.text() },
      { status: 502 }
    );
  }

  return Response.json({
    connected: true,
    message: "Reached the Supabase project successfully.",
    projectUrl: supabaseUrl,
  });
}
