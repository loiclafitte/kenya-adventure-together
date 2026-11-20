import { createFileRoute } from "@tanstack/react-router";
import { EmptyState, PageHeader } from "@/components/PageHeader";

export const Route = createFileRoute("/_authenticated/infos")({
  head: () => ({
    meta: [
      { title: "Infos pratiques · Karibu Kenya" },
      { name: "description", content: "Infos pratiques du voyage Karibu Kenya." },
      { property: "og:title", content: "Infos pratiques · Karibu Kenya" },
      { property: "og:description", content: "Infos pratiques du voyage Karibu Kenya." },
    ],
  }),
  component: Page,
});

function Page() {
  return (
    <main className="mx-auto max-w-lg pb-safe-nav">
      <PageHeader eyebrow="Karibu Kenya" title="Infos pratiques" />
      <EmptyState emoji="🦒" title="Page en construction" text="Cette page arrive bientôt." />
    </main>
  );
}
