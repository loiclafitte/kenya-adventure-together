import { createFileRoute } from "@tanstack/react-router";
import { EmptyState, PageHeader } from "@/components/PageHeader";

export const Route = createFileRoute("/auth")({
  head: () => ({
    meta: [
      { title: "Connexion · Karibu Kenya" },
      { name: "description", content: "Connexion au voyage Karibu Kenya par lien email." },
      { property: "og:title", content: "Connexion · Karibu Kenya" },
      { property: "og:description", content: "Connexion au voyage Karibu Kenya par lien email." },
    ],
  }),
  component: AuthPage,
});

function AuthPage() {
  return (
    <main className="mx-auto max-w-lg pb-safe-nav">
      <PageHeader eyebrow="Karibu Kenya" title="Connexion" />
      <EmptyState emoji="✉️" title="Connexion par lien email" text="Cette page arrive bientôt." />
    </main>
  );
}
