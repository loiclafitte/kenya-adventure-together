import nairobiImg from "@/assets/region-nairobi.jpg";
import maraImg from "@/assets/region-mara.jpg";
import nyamiraImg from "@/assets/region-nyamira.jpg";
import { format, parseISO } from "date-fns";
import { fr } from "date-fns/locale";

export const TRIP = {
  name: "Karibu Kenya",
  tagline: "Nairobi, le Masai Mara et les collines de thé de Nyamira, entre amis",
  start: "2026-12-30",
  end: "2027-01-10",
};

export const REGION_IMAGES: Record<string, string> = {
  nairobi: nairobiImg,
  mara: maraImg,
  nyamira: nyamiraImg,
};

export const REGIONS = [
  { value: "nairobi", label: "Nairobi" },
  { value: "mara", label: "Masai Mara" },
  { value: "nyamira", label: "Nyamira & collines de thé" },
];

export function regionImage(region: string | null | undefined) {
  return REGION_IMAGES[region ?? ""] ?? maraImg;
}

export const CATEGORIES: Record<string, { label: string; emoji: string }> = {
  safari: { label: "Safari", emoji: "🦓" },
  animaux: { label: "Animaux", emoji: "🐘" },
  visite: { label: "Visite", emoji: "🏛️" },
  culture: { label: "Culture", emoji: "🥁" },
  repas: { label: "Repas", emoji: "🍲" },
  detente: { label: "Détente", emoji: "🌴" },
  transport: { label: "Trajet", emoji: "🚙" },
  hebergement: { label: "Hébergement", emoji: "⛺" },
  jeu: { label: "Jeu", emoji: "🏆" },
};

export function categoryMeta(cat: string) {
  return CATEGORIES[cat] ?? { label: cat, emoji: "📍" };
}

/** Team color key -> semantic token classes */
export const TEAM_COLORS: Record<string, { bg: string; text: string; soft: string; ring: string }> = {
  ochre: { bg: "bg-ochre", text: "text-ochre-foreground", soft: "bg-ochre/15", ring: "border-ochre" },
  acacia: { bg: "bg-acacia", text: "text-acacia-foreground", soft: "bg-acacia/15", ring: "border-acacia" },
  flamingo: { bg: "bg-flamingo", text: "text-flamingo-foreground", soft: "bg-flamingo/15", ring: "border-flamingo" },
  lagoon: { bg: "bg-lagoon", text: "text-lagoon-foreground", soft: "bg-lagoon/15", ring: "border-lagoon" },
};

export const TEAM_COLOR_OPTIONS = [
  { value: "ochre", label: "Ocre" },
  { value: "acacia", label: "Acacia" },
  { value: "flamingo", label: "Flamant" },
  { value: "lagoon", label: "Lagon" },
];

export function teamColor(key: string | null | undefined) {
  return TEAM_COLORS[key ?? ""] ?? TEAM_COLORS["ochre"]!;
}

/** Day colors on the map, cycling through the palette tokens */
export const DAY_PIN_VARS = ["--primary", "--acacia", "--lagoon", "--ochre", "--flamingo", "--earth"];

export function formatDayDate(date: string | null | undefined, pattern = "EEEE d MMMM") {
  if (!date) return "";
  return format(parseISO(date), pattern, { locale: fr });
}

export function formatTripRange() {
  return `${formatDayDate(TRIP.start, "d MMMM yyyy")} → ${formatDayDate(TRIP.end, "d MMMM yyyy")}`;
}
