import { createFileRoute } from "@tanstack/react-router";
import { EmptyState, PageHeader } from "@/components/PageHeader";

export const Route = createFileRoute("/_authenticated/scores")({
  head: () => ({
    meta: [
      { title: "Proposer un score · Karibu Kenya" },
      { name: "description", content: "Proposer un score du voyage Karibu Kenya." },
      { property: "og:title", content: "Proposer un score · Karibu Kenya" },
      { property: "og:description", content: "Proposer un score du voyage Karibu Kenya." },
    ],
  }),
  component: Page,
});

function Page() {
  return (
    <main className="mx-auto max-w-lg pb-safe-nav">
      <PageHeader eyebrow="Karibu Kenya" title="Proposer un score" />
      <EmptyState emoji="🦒" title="Page en construction" text="Cette page arrive bientôt." />
    </main>
  );
}
