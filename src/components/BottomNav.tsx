import { Link, useRouterState } from "@tanstack/react-router";
import {
  CalendarDays,
  Home,
  Map,
  Menu,
  Trophy,
  Info,
  Users,
  Shield,
  Gamepad2,
  PenLine,
  LogOut,
  Flag,
} from "lucide-react";
import { useState } from "react";
import { Sheet, SheetContent, SheetHeader, SheetTitle } from "@/components/ui/sheet";
import { useAuth } from "@/hooks/use-auth";
import { cn } from "@/lib/utils";

const main = [
  { to: "/", label: "Accueil", icon: Home },
  { to: "/programme", label: "Programme", icon: CalendarDays },
  { to: "/carte", label: "Carte", icon: Map },
  { to: "/classement", label: "Classement", icon: Trophy },
] as const;

const more = [
  { to: "/infos", label: "Infos pratiques", icon: Info },
  { to: "/participants", label: "Participants", icon: Users },
  { to: "/equipes", label: "Équipes", icon: Flag },
  { to: "/jeux", label: "Jeux", icon: Gamepad2 },
  { to: "/scores", label: "Proposer un score", icon: PenLine },
] as const;

export function BottomNav() {
  const pathname = useRouterState({ select: (s) => s.location.pathname });
  const [open, setOpen] = useState(false);
  const { user, isAdmin, signOut } = useAuth();

  const isActive = (to: string) => (to === "/" ? pathname === "/" : pathname.startsWith(to));
  const moreActive = [...more.map((m) => m.to), "/admin"].some((to) => pathname.startsWith(to));

  return (
    <>
      <nav className="fixed inset-x-0 bottom-0 z-40 border-t border-border bg-card/95 pb-[env(safe-area-inset-bottom)] backdrop-blur">
        <div className="shuka-band h-1 w-full" />
        <ul className="mx-auto grid max-w-lg grid-cols-5">
          {main.map(({ to, label, icon: Icon }) => (
            <li key={to}>
              <Link
                to={to}
                className={cn(
                  "flex flex-col items-center gap-1 py-2.5 text-[11px] font-semibold transition-colors",
                  isActive(to) ? "text-primary" : "text-muted-foreground",
                )}
              >
                <Icon className={cn("size-5", isActive(to) && "stroke-[2.5]")} />
                {label}
              </Link>
            </li>
          ))}
          <li>
            <button
              type="button"
              onClick={() => setOpen(true)}
              className={cn(
                "flex w-full flex-col items-center gap-1 py-2.5 text-[11px] font-semibold",
                moreActive ? "text-primary" : "text-muted-foreground",
              )}
            >
              <Menu className="size-5" />
              Plus
            </button>
          </li>
        </ul>
      </nav>

      <Sheet open={open} onOpenChange={setOpen}>
        <SheetContent side="bottom" className="rounded-t-3xl border-border bg-card pb-8">
          <SheetHeader>
            <SheetTitle className="font-display text-2xl">Plus</SheetTitle>
          </SheetHeader>
          <div className="mt-4 grid grid-cols-2 gap-3">
            {more.map(({ to, label, icon: Icon }) => (
              <Link
                key={to}
                to={to}
                onClick={() => setOpen(false)}
                className="flex items-center gap-3 rounded-2xl bg-secondary px-4 py-3.5 text-sm font-semibold text-secondary-foreground"
              >
                <Icon className="size-5 text-primary" />
                {label}
              </Link>
            ))}
            {isAdmin && (
              <Link
                to="/admin"
                onClick={() => setOpen(false)}
                className="flex items-center gap-3 rounded-2xl bg-earth px-4 py-3.5 text-sm font-semibold text-earth-foreground"
              >
                <Shield className="size-5" />
                Administration
              </Link>
            )}
          </div>
          {user && (
            <button
              type="button"
              onClick={() => {
                setOpen(false);
                void signOut();
              }}
              className="mt-6 flex w-full items-center justify-center gap-2 rounded-2xl border border-border py-3 text-sm font-semibold text-muted-foreground"
            >
              <LogOut className="size-4" />
              Se déconnecter
            </button>
          )}
        </SheetContent>
      </Sheet>
    </>
  );
}
