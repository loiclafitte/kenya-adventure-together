import { createFileRoute } from "@tanstack/react-router";
import { EmptyState, PageHeader } from "@/components/PageHeader";

export const Route = createFileRoute("/_authenticated/participants")({
  head: () => ({
    meta: [
      { title: "Participants · Karibu Kenya" },
      { name: "description", content: "Participants du voyage Karibu Kenya." },
      { property: "og:title", content: "Participants · Karibu Kenya" },
      { property: "og:description", content: "Participants du voyage Karibu Kenya." },
    ],
  }),
  component: Page,
});

function Page() {
  return (
    <main className="mx-auto max-w-lg pb-safe-nav">
      <PageHeader eyebrow="Karibu Kenya" title="Participants" />
      <EmptyState emoji="🦒" title="Page en construction" text="Cette page arrive bientôt." />
    </main>
  );
}
