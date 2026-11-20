import { createFileRoute } from "@tanstack/react-router";
import { EmptyState, PageHeader } from "@/components/PageHeader";

export const Route = createFileRoute("/_authenticated/equipes")({
  head: () => ({
    meta: [
      { title: "Équipes · Karibu Kenya" },
      { name: "description", content: "Équipes du voyage Karibu Kenya." },
      { property: "og:title", content: "Équipes · Karibu Kenya" },
      { property: "og:description", content: "Équipes du voyage Karibu Kenya." },
    ],
  }),
  component: Page,
});

function Page() {
  return (
    <main className="mx-auto max-w-lg pb-safe-nav">
      <PageHeader eyebrow="Karibu Kenya" title="Équipes" />
      <EmptyState emoji="🦒" title="Page en construction" text="Cette page arrive bientôt." />
    </main>
  );
}
