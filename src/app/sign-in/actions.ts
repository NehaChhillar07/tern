"use server"

import { headers } from "next/headers"
import { redirect } from "next/navigation"
import { createClient } from "@/lib/supabase/server"

export type SignInState = { status: "idle" } | { status: "sent"; email: string } | { status: "error"; email: string; message: string }

export async function sendSignInLink(_prev: SignInState, formData: FormData): Promise<SignInState> {
  const email = String(formData.get("email") ?? "").trim().toLowerCase()
  if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
    return { status: "error", email, message: "That email address doesn't look right. Check it and try again." }
  }

  const h = await headers()
  const host = h.get("x-forwarded-host") ?? h.get("host")
  const proto = h.get("x-forwarded-proto") ?? "https"
  const supabase = await createClient()
  const { error } = await supabase.auth.signInWithOtp({
    email,
    options: { emailRedirectTo: `${proto}://${host}/auth/callback` },
  })

  if (error) {
    const message =
      error.status === 429
        ? "Too many sign-in emails were requested. Wait a few minutes, then try again."
        : "The sign-in link couldn't be sent. Try again in a moment."
    return { status: "error", email, message }
  }
  return { status: "sent", email }
}

export async function signOut() {
  const supabase = await createClient()
  await supabase.auth.signOut()
  redirect("/")
}
