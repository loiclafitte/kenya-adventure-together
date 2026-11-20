import { createFileRoute } from "@tanstack/react-router";
import { EmptyState, PageHeader } from "@/components/PageHeader";

export const Route = createFileRoute("/_authenticated/programme")({
  head: () => ({
    meta: [
      { title: "Programme jour par jour · Karibu Kenya" },
      { name: "description", content: "Programme jour par jour du voyage Karibu Kenya." },
      { property: "og:title", content: "Programme jour par jour · Karibu Kenya" },
      { property: "og:description", content: "Programme jour par jour du voyage Karibu Kenya." },
    ],
  }),
  component: Page,
});

function Page() {
  return (
    <main className="mx-auto max-w-lg pb-safe-nav">
      <PageHeader eyebrow="Karibu Kenya" title="Programme jour par jour" />
      <EmptyState emoji="🦒" title="Page en construction" text="Cette page arrive bientôt." />
    </main>
  );
}
