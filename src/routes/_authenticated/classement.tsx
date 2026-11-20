import { createFileRoute } from "@tanstack/react-router";
import { EmptyState, PageHeader } from "@/components/PageHeader";

export const Route = createFileRoute("/_authenticated/classement")({
  head: () => ({
    meta: [
      { title: "Classement général · Karibu Kenya" },
      { name: "description", content: "Classement général du voyage Karibu Kenya." },
      { property: "og:title", content: "Classement général · Karibu Kenya" },
      { property: "og:description", content: "Classement général du voyage Karibu Kenya." },
    ],
  }),
  component: Page,
});

function Page() {
  return (
    <main className="mx-auto max-w-lg pb-safe-nav">
      <PageHeader eyebrow="Karibu Kenya" title="Classement général" />
      <EmptyState emoji="🦒" title="Page en construction" text="Cette page arrive bientôt." />
    </main>
  );
}
