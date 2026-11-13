import type { Metadata } from "next"
import Link from "next/link"
import { Suspense } from "react"
import { Orb } from "@/components/tern/orb"
import { SignInForm } from "./sign-in-form"

export const metadata: Metadata = { title: "Sign in to Tern" }

export default function SignInPage({ searchParams }: PageProps<"/sign-in">) {
  return (
    <>
      <div className="bloom" aria-hidden="true" />
      <header className="relative z-10 mx-auto flex w-full max-w-[720px] items-center px-4 py-3.5">
        <Link href="/" className="font-heading text-xl font-medium tracking-tight text-foreground">
          tern
        </Link>
      </header>
      <main className="relative z-10 mx-auto flex w-full max-w-[420px] flex-1 flex-col gap-6 px-4 pt-7 pb-9">
        <div className="flex flex-col gap-3.5">
          <Orb />
          <h1 className="type-title">Sign in to Tern</h1>
          <p className="text-muted-foreground">Enter your email and I&apos;ll send you a link that signs you in.</p>
        </div>
        <Suspense fallback={null}>
          <LinkProblem searchParams={searchParams} />
        </Suspense>
        <SignInForm />
      </main>
    </>
  )
}

async function LinkProblem({ searchParams }: { searchParams: PageProps<"/sign-in">["searchParams"] }) {
  const { problem } = await searchParams
  if (problem !== "link") return null
  return (
    <p role="alert" className="rounded-lg bg-alert-soft p-3 text-sm text-destructive">
      That sign-in link has expired or was already used. Enter your email to get a new one.
    </p>
  )
}
