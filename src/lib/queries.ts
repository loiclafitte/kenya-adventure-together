import { queryOptions } from "@tanstack/react-query";
import { supabase } from "@/integrations/supabase/client";
import type { Tables } from "@/integrations/supabase/types";

export type Day = Tables<"days">;
export type Activity = Tables<"activities">;
export type Team = Tables<"teams">;
export type Participant = Tables<"participants">;
export type Game = Tables<"games">;
export type Score = Tables<"scores">;
export type Info = Tables<"practical_info">;

function unwrap<T>(res: { data: T | null; error: { message: string } | null }): T {
  if (res.error) throw new Error(res.error.message);
  return res.data as T;
}

export const daysQuery = queryOptions({
  queryKey: ["days"],
  queryFn: async () =>
    unwrap(await supabase.from("days").select("*").order("day_number")) as Day[],
});

export const activitiesQuery = queryOptions({
  queryKey: ["activities"],
  queryFn: async () =>
    unwrap(
      await supabase.from("activities").select("*").order("sort").order("start_time"),
    ) as Activity[],
});

export const teamsQuery = queryOptions({
  queryKey: ["teams"],
  queryFn: async () => unwrap(await supabase.from("teams").select("*").order("sort")) as Team[],
});

export const participantsQuery = queryOptions({
  queryKey: ["participants"],
  queryFn: async () =>
    unwrap(
      await supabase.from("participants").select("*").order("display_name"),
    ) as Participant[],
});

export const gamesQuery = queryOptions({
  queryKey: ["games"],
  queryFn: async () => unwrap(await supabase.from("games").select("*").order("sort")) as Game[],
});

export const scoresQuery = queryOptions({
  queryKey: ["scores"],
  queryFn: async () =>
    unwrap(
      await supabase.from("scores").select("*").order("created_at", { ascending: false }),
    ) as Score[],
});

export const infosQuery = queryOptions({
  queryKey: ["practical_info"],
  queryFn: async () =>
    unwrap(await supabase.from("practical_info").select("*").order("sort")) as Info[],
});
