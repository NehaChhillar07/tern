import { createServerClient } from "@supabase/ssr"
import { cookies } from "next/headers"
import { SUPABASE_PUBLISHABLE_KEY, SUPABASE_URL } from "./config"

/** Supabase client for server components, server actions and route handlers. Acts as the signed-in user. */
export async function createClient() {
  const cookieStore = await cookies()
  return createServerClient(SUPABASE_URL, SUPABASE_PUBLISHABLE_KEY, {
    cookies: {
      getAll: () => cookieStore.getAll(),
      setAll: (toSet) => {
        try {
          toSet.forEach(({ name, value, options }) => cookieStore.set(name, value, options))
        } catch {
          // Server components cannot set cookies. The proxy refreshes the session instead.
        }
      },
    },
  })
}
