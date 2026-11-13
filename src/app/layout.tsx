import type { Metadata } from "next"
import "@fontsource-variable/inter"
import "@fontsource-variable/inter-tight"
import "./globals.css"

export const metadata: Metadata = {
  title: "Tern",
  description: "An AI counsellor for studying abroad. Real courses, real deadlines, every fact with its source.",
}

export default function RootLayout({ children }: LayoutProps<"/">) {
  return (
    <html lang="en" className="h-full antialiased">
      <body className="flex min-h-full flex-col">{children}</body>
    </html>
  )
}
