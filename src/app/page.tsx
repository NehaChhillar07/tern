import { Suspense } from "react"
import { Account } from "@/components/tern/account"
import { Orb } from "@/components/tern/orb"

export default function Home() {
  return (
    <>
      <div className="bloom" aria-hidden="true" />
      <header className="relative z-10 mx-auto flex min-h-16 w-full max-w-[720px] items-center justify-between px-4 py-3.5">
        <span className="font-heading text-xl font-medium tracking-tight text-foreground">tern</span>
        <Suspense fallback={null}>
          <Account />
        </Suspense>
      </header>
      <main className="relative z-10 mx-auto flex w-full max-w-[720px] flex-1 flex-col gap-3.5 px-4 pt-7 pb-9">
        <Orb />
        <h1 className="type-headline">
          Hi, I&apos;m Tern. <span className="text-muted-foreground">I help you study abroad, from your first shortlist to your visa.</span>
        </h1>
        <p className="text-muted-foreground">I&apos;m still being built. You&apos;ll be able to talk to me here soon.</p>
      </main>
    </>
  )
}
