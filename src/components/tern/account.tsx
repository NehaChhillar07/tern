import Link from "next/link"
import { signOut } from "@/app/sign-in/actions"
import { Button } from "@/components/ui/button"
import { createClient } from "@/lib/supabase/server"

/** Top-right of the header: who is signed in, or a way to sign in. */
export async function Account() {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()

  if (!user) {
    return (
      <Button variant="outline" nativeButton={false} render={<Link href="/sign-in" />}>
        Sign in
      </Button>
    )
  }
  return (
    <form action={signOut} className="flex items-center gap-3">
      <span className="hidden text-sm text-muted-foreground sm:inline">{user.email}</span>
      <Button type="submit" variant="outline">
        Sign out
      </Button>
    </form>
  )
}
