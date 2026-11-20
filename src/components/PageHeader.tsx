import type { ReactNode } from "react";

export function PageHeader({
  eyebrow,
  title,
  subtitle,
  action,
}: {
  eyebrow?: string;
  title: string;
  subtitle?: string;
  action?: ReactNode;
}) {
  return (
    <header className="px-5 pt-8 pb-5">
      {eyebrow && (
        <p className="text-xs font-bold uppercase tracking-[0.18em] text-primary">{eyebrow}</p>
      )}
      <div className="mt-1 flex items-end justify-between gap-3">
        <h1 className="font-display text-3xl font-semibold leading-tight text-foreground">
          {title}
        </h1>
        {action}
      </div>
      {subtitle && <p className="mt-2 text-sm text-muted-foreground">{subtitle}</p>}
    </header>
  );
}

export function EmptyState({ emoji, title, text }: { emoji: string; title: string; text?: string }) {
  return (
    <div className="mx-5 rounded-3xl border border-dashed border-border bg-card/60 px-6 py-10 text-center">
      <div className="text-4xl">{emoji}</div>
      <p className="mt-3 font-display text-lg font-semibold">{title}</p>
      {text && <p className="mt-1 text-sm text-muted-foreground">{text}</p>}
    </div>
  );
}
