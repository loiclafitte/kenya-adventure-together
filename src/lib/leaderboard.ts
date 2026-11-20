export type LeaderboardTeam = { id: string; name: string; emoji: string; color: string };
export type LeaderboardScore = { team_id: string; game_id: string; points: number; status: string };

export type LeaderboardRow = LeaderboardTeam & {
  total: number;
  gamesPlayed: number;
  byGame: Record<string, number>;
  rank: number;
};

/**
 * Only scores validated by the admin count toward the general ranking.
 * Teams with equal totals share the same rank.
 */
export function computeLeaderboard(
  teams: LeaderboardTeam[],
  scores: LeaderboardScore[],
): LeaderboardRow[] {
  const rows = teams.map((t) => {
    const mine = scores.filter((s) => s.team_id === t.id && s.status === "validated");
    const byGame: Record<string, number> = {};
    for (const s of mine) byGame[s.game_id] = (byGame[s.game_id] ?? 0) + s.points;
    return {
      ...t,
      total: mine.reduce((sum, s) => sum + s.points, 0),
      gamesPlayed: Object.keys(byGame).length,
      byGame,
      rank: 0,
    };
  });
  rows.sort((a, b) => b.total - a.total || a.name.localeCompare(b.name));
  rows.forEach((r, i) => {
    const prev = rows[i - 1];
    r.rank = prev && prev.total === r.total ? prev.rank : i + 1;
  });
  return rows;
}
