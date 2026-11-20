export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "14.18"
  }
  public: {
    Tables: {
      activities: {
        Row: {
          category: string
          created_at: string
          day_id: string
          description: string
          id: string
          lat: number | null
          lng: number | null
          place: string
          sort: number
          start_time: string
          title: string
        }
        Insert: {
          category?: string
          created_at?: string
          day_id: string
          description?: string
          id?: string
          lat?: number | null
          lng?: number | null
          place?: string
          sort?: number
          start_time?: string
          title: string
        }
        Update: {
          category?: string
          created_at?: string
          day_id?: string
          description?: string
          id?: string
          lat?: number | null
          lng?: number | null
          place?: string
          sort?: number
          start_time?: string
          title?: string
        }
        Relationships: [
          {
            foreignKeyName: "activities_day_id_fkey"
            columns: ["day_id"]
            isOneToOne: false
            referencedRelation: "days"
            referencedColumns: ["id"]
          },
        ]
      }
      days: {
        Row: {
          accommodation: string | null
          created_at: string
          date: string | null
          day_number: number
          description: string
          id: string
          lat: number | null
          lng: number | null
          location: string
          region: string
          summary: string
          title: string
        }
        Insert: {
          accommodation?: string | null
          created_at?: string
          date?: string | null
          day_number: number
          description?: string
          id?: string
          lat?: number | null
          lng?: number | null
          location?: string
          region?: string
          summary?: string
          title: string
        }
        Update: {
          accommodation?: string | null
          created_at?: string
          date?: string | null
          day_number?: number
          description?: string
          id?: string
          lat?: number | null
          lng?: number | null
          location?: string
          region?: string
          summary?: string
          title?: string
        }
        Relationships: []
      }
      games: {
        Row: {
          created_at: string
          day_id: string | null
          description: string
          emoji: string
          id: string
          max_points: number
          name: string
          rules: string
          sort: number
        }
        Insert: {
          created_at?: string
          day_id?: string | null
          description?: string
          emoji?: string
          id?: string
          max_points?: number
          name: string
          rules?: string
          sort?: number
        }
        Update: {
          created_at?: string
          day_id?: string | null
          description?: string
          emoji?: string
          id?: string
          max_points?: number
          name?: string
          rules?: string
          sort?: number
        }
        Relationships: [
          {
            foreignKeyName: "games_day_id_fkey"
            columns: ["day_id"]
            isOneToOne: false
            referencedRelation: "days"
            referencedColumns: ["id"]
          },
        ]
      }
      participants: {
        Row: {
          bio: string | null
          created_at: string
          display_name: string
          emoji: string
          id: string
          team_id: string | null
          user_id: string | null
        }
        Insert: {
          bio?: string | null
          created_at?: string
          display_name: string
          emoji?: string
          id?: string
          team_id?: string | null
          user_id?: string | null
        }
        Update: {
          bio?: string | null
          created_at?: string
          display_name?: string
          emoji?: string
          id?: string
          team_id?: string | null
          user_id?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "participants_team_id_fkey"
            columns: ["team_id"]
            isOneToOne: false
            referencedRelation: "teams"
            referencedColumns: ["id"]
          },
        ]
      }
      practical_info: {
        Row: {
          category: string
          content: string
          created_at: string
          emoji: string
          id: string
          sort: number
          title: string
        }
        Insert: {
          category: string
          content: string
          created_at?: string
          emoji?: string
          id?: string
          sort?: number
          title: string
        }
        Update: {
          category?: string
          content?: string
          created_at?: string
          emoji?: string
          id?: string
          sort?: number
          title?: string
        }
        Relationships: []
      }
      scores: {
        Row: {
          comment: string | null
          created_at: string
          game_id: string
          id: string
          points: number
          reviewed_at: string | null
          reviewed_by: string | null
          status: string
          submitted_by: string | null
          team_id: string
        }
        Insert: {
          comment?: string | null
          created_at?: string
          game_id: string
          id?: string
          points: number
          reviewed_at?: string | null
          reviewed_by?: string | null
          status?: string
          submitted_by?: string | null
          team_id: string
        }
        Update: {
          comment?: string | null
          created_at?: string
          game_id?: string
          id?: string
          points?: number
          reviewed_at?: string | null
          reviewed_by?: string | null
          status?: string
          submitted_by?: string | null
          team_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "scores_game_id_fkey"
            columns: ["game_id"]
            isOneToOne: false
            referencedRelation: "games"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "scores_team_id_fkey"
            columns: ["team_id"]
            isOneToOne: false
            referencedRelation: "teams"
            referencedColumns: ["id"]
          },
        ]
      }
      teams: {
        Row: {
          color: string
          created_at: string
          emoji: string
          id: string
          motto: string | null
          name: string
          sort: number
        }
        Insert: {
          color?: string
          created_at?: string
          emoji?: string
          id?: string
          motto?: string | null
          name: string
          sort?: number
        }
        Update: {
          color?: string
          created_at?: string
          emoji?: string
          id?: string
          motto?: string | null
          name?: string
          sort?: number
        }
        Relationships: []
      }
      user_roles: {
        Row: {
          id: string
          role: Database["public"]["Enums"]["app_role"]
          user_id: string
        }
        Insert: {
          id?: string
          role: Database["public"]["Enums"]["app_role"]
          user_id: string
        }
        Update: {
          id?: string
          role?: Database["public"]["Enums"]["app_role"]
          user_id?: string
        }
        Relationships: []
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      has_role: {
        Args: {
          _role: Database["public"]["Enums"]["app_role"]
          _user_id: string
        }
        Returns: boolean
      }
    }
    Enums: {
      app_role: "admin" | "participant"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never) = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never) = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never) = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends (DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never) = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends (PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never) = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {
      app_role: ["admin", "participant"],
    },
  },
} as const
