import { teamColor } from "@/lib/trip";
import { cn } from "@/lib/utils";

export function TeamBadge({
  team,
  className,
}: {
  team: { name: string; emoji: string; color: string } | null | undefined;
  className?: string;
}) {
  if (!team)
    return (
      <span
        className={cn(
          "inline-flex items-center rounded-full bg-muted px-2.5 py-0.5 text-xs font-semibold text-muted-foreground",
          className,
        )}
      >
        Sans équipe
      </span>
    );
  const c = teamColor(team.color);
  return (
    <span
      className={cn(
        "inline-flex items-center gap-1 rounded-full px-2.5 py-0.5 text-xs font-bold",
        c.bg,
        c.text,
        className,
      )}
    >
      <span aria-hidden>{team.emoji}</span>
      {team.name}
    </span>
  );
}
