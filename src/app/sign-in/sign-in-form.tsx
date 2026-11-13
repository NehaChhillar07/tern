"use client"

import { useActionState } from "react"
import { Button } from "@/components/ui/button"
import { Field, FieldDescription, FieldError, FieldGroup, FieldLabel } from "@/components/ui/field"
import { Input } from "@/components/ui/input"
import { sendSignInLink, type SignInState } from "./actions"

const initial: SignInState = { status: "idle" }

export function SignInForm() {
  const [state, action, pending] = useActionState(sendSignInLink, initial)

  if (state.status === "sent") {
    return (
      <div role="status" className="flex flex-col gap-2 rounded-lg border bg-card p-4">
        <p className="font-medium text-foreground">Check your inbox.</p>
        <p>
          I sent a sign-in link to <span className="text-foreground">{state.email}</span>. Open it on this device. It works once
          and expires in an hour.
        </p>
      </div>
    )
  }

  const invalid = state.status === "error"
  return (
    <form action={action} noValidate>
      <FieldGroup>
        <Field data-invalid={invalid || undefined}>
          <FieldLabel htmlFor="email">Email</FieldLabel>
          <Input
            id="email"
            name="email"
            type="email"
            inputMode="email"
            autoComplete="email"
            spellCheck={false}
            placeholder="you@example.com"
            defaultValue={invalid ? state.email : ""}
            aria-invalid={invalid || undefined}
            aria-describedby={invalid ? "email-error" : "email-help"}
            required
          />
          {invalid ? (
            <FieldError id="email-error">{state.message}</FieldError>
          ) : (
            <FieldDescription id="email-help">No password needed.</FieldDescription>
          )}
        </Field>
        <Button type="submit" size="lg" disabled={pending}>
          {pending ? "Sending…" : "Send sign-in link"}
        </Button>
      </FieldGroup>
    </form>
  )
}
