import { createFileRoute } from "@tanstack/react-router";
import { EmptyState, PageHeader } from "@/components/PageHeader";

export const Route = createFileRoute("/_authenticated/carte")({
  head: () => ({
    meta: [
      { title: "Carte des lieux · Karibu Kenya" },
      { name: "description", content: "Carte des lieux du voyage Karibu Kenya." },
      { property: "og:title", content: "Carte des lieux · Karibu Kenya" },
      { property: "og:description", content: "Carte des lieux du voyage Karibu Kenya." },
    ],
  }),
  component: Page,
});

function Page() {
  return (
    <main className="mx-auto max-w-lg pb-safe-nav">
      <PageHeader eyebrow="Karibu Kenya" title="Carte des lieux" />
      <EmptyState emoji="🦒" title="Page en construction" text="Cette page arrive bientôt." />
    </main>
  );
}
