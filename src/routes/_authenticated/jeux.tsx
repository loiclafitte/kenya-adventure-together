import { createFileRoute } from "@tanstack/react-router";
import { EmptyState, PageHeader } from "@/components/PageHeader";

export const Route = createFileRoute("/_authenticated/jeux")({
  head: () => ({
    meta: [
      { title: "Jeux · Karibu Kenya" },
      { name: "description", content: "Jeux du voyage Karibu Kenya." },
      { property: "og:title", content: "Jeux · Karibu Kenya" },
      { property: "og:description", content: "Jeux du voyage Karibu Kenya." },
    ],
  }),
  component: Page,
});

function Page() {
  return (
    <main className="mx-auto max-w-lg pb-safe-nav">
      <PageHeader eyebrow="Karibu Kenya" title="Jeux" />
      <EmptyState emoji="🦒" title="Page en construction" text="Cette page arrive bientôt." />
    </main>
  );
}
