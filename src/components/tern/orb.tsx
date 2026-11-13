import { cn } from "@/lib/utils"

type OrbProps = {
  state?: "resting" | "working"
  size?: "md" | "sm"
  className?: string
}

/** Tern itself. Decorative: the text beside it carries the meaning. */
export function Orb({ state = "resting", size = "md", className }: OrbProps) {
  return <div aria-hidden="true" data-state={state} data-size={size} className={cn("orb", className)} />
}
