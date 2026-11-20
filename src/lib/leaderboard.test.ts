import { describe, expect, it } from "vitest";
import { computeLeaderboard } from "./leaderboard";

const teams = [
  { id: "a", name: "Lions", emoji: "🦁", color: "ochre" },
  { id: "b", name: "Girafes", emoji: "🦒", color: "acacia" },
  { id: "c", name: "Flamants", emoji: "🦩", color: "flamingo" },
];

describe("computeLeaderboard", () => {
  it("counts only scores validated by the admin", () => {
    const rows = computeLeaderboard(teams, [
      { team_id: "a", game_id: "g1", points: 10, status: "validated" },
      { team_id: "a", game_id: "g2", points: 50, status: "pending" },
      { team_id: "a", game_id: "g3", points: 40, status: "rejected" },
    ]);
    expect(rows.find((r) => r.id === "a")?.total).toBe(10);
  });

  it("ranks teams by total points, highest first", () => {
    const rows = computeLeaderboard(teams, [
      { team_id: "a", game_id: "g1", points: 5, status: "validated" },
      { team_id: "b", game_id: "g1", points: 12, status: "validated" },
      { team_id: "c", game_id: "g1", points: 8, status: "validated" },
    ]);
    expect(rows.map((r) => r.id)).toEqual(["b", "c", "a"]);
    expect(rows[0]?.rank).toBe(1);
  });

  it("gives tied teams the same rank", () => {
    const rows = computeLeaderboard(teams, [
      { team_id: "a", game_id: "g1", points: 7, status: "validated" },
      { team_id: "b", game_id: "g1", points: 7, status: "validated" },
    ]);
    expect(rows[0]?.rank).toBe(1);
    expect(rows[1]?.rank).toBe(1);
    expect(rows[2]?.rank).toBe(3);
  });
});
