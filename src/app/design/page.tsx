import type { Metadata } from "next"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import { Separator } from "@/components/ui/separator"
import { Orb } from "@/components/tern/orb"

export const metadata: Metadata = { title: "Tern design tokens" }

const surfaces = [
  ["background", "bg-background"],
  ["card", "bg-card"],
  ["secondary", "bg-secondary"],
  ["primary", "bg-primary"],
  ["border", "bg-border"],
  ["input", "bg-input"],
] as const

const glows = ["--mint", "--peach", "--lilac", "--sky", "--rose"] as const

export default function DesignPage() {
  return (
    <main className="mx-auto flex w-full max-w-[720px] flex-col gap-11 px-4 py-9">
      <div className="flex flex-col gap-3.5">
        <h1 className="type-headline">
          Design tokens. <span className="text-muted-foreground">Everything on screen is built from these.</span>
        </h1>
        <p className="text-muted-foreground">Source of truth: DESIGN.md. This page follows your system light or dark setting.</p>
      </div>

      <section className="flex flex-col gap-3.5">
        <h2 className="text-[15px] font-medium text-foreground">Surfaces</h2>
        <ul className="grid grid-cols-2 gap-3 sm:grid-cols-3">
          {surfaces.map(([name, cls]) => (
            <li key={name} className="flex flex-col gap-1.5">
              <div className={`h-16 rounded-lg border ${cls}`} />
              <span className="text-sm">{name}</span>
            </li>
          ))}
        </ul>
      </section>

      <section className="flex flex-col gap-3.5">
        <h2 className="text-[15px] font-medium text-foreground">Glows</h2>
        <ul className="grid grid-cols-3 gap-3 sm:grid-cols-5">
          {glows.map((g) => (
            <li key={g} className="flex flex-col gap-1.5">
              <div className="h-16 rounded-lg border" style={{ background: `radial-gradient(circle at 30% 20%, var(${g}), transparent 75%)` }} />
              <span className="text-sm">{g.slice(2)}</span>
            </li>
          ))}
        </ul>
      </section>

      <section className="flex flex-col gap-3.5">
        <h2 className="text-[15px] font-medium text-foreground">Type</h2>
        <div className="flex flex-col gap-3 rounded-lg border bg-card p-4">
          <p className="type-headline">Good morning, Rahul.</p>
          <Separator />
          <p className="type-title">MSc Business Analytics</p>
          <Separator />
          <p>Body text is Inter at 16px. I checked 14 university pages overnight.</p>
          <Separator />
          <p className="text-sm text-muted-foreground">Small text is 14px in muted grey.</p>
          <Separator />
          <p className="type-caption text-muted-foreground">Gate closes</p>
        </div>
      </section>

      <section className="flex flex-col gap-3.5">
        <h2 className="text-[15px] font-medium text-foreground">Controls</h2>
        <div className="flex flex-wrap items-center gap-3">
          <Button>Read the draft</Button>
          <Button variant="outline">Track</Button>
          <Button variant="ghost">Close</Button>
          <Badge variant="secondary">Good match</Badge>
        </div>
      </section>

      <section className="flex flex-col gap-3.5">
        <h2 className="text-[15px] font-medium text-foreground">Orb</h2>
        <div className="flex items-center gap-6">
          <Orb />
          <Orb state="working" />
          <Orb size="sm" />
        </div>
        <p className="text-sm text-muted-foreground">Resting, working, and the small size used inside a run.</p>
      </section>
    </main>
  )
}
