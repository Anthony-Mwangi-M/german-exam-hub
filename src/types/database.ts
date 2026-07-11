import type { AudioLicense, ExamFormat, ExamTaskType, InstructorRubric } from './exam';

export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type { AudioLicense, ExamFormat, ExamTaskType, InstructorRubric };

export interface Database {
  public: {
    Tables: {
      profiles: {
        Row: {
          id: string
          email: string
          full_name: string | null
          role: 'user' | 'admin'
          created_at: string
          updated_at: string
        }
        Insert: {
          id: string
          email: string
          full_name?: string | null
          role?: 'user' | 'admin'
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          email?: string
          full_name?: string | null
          role?: 'user' | 'admin'
          created_at?: string
          updated_at?: string
        }
      }
      levels: {
        Row: {
          id: string
          code: string
          name: string
          description: string | null
          order: number
          created_at: string
        }
        Insert: {
          id?: string
          code: string
          name: string
          description?: string | null
          order: number
          created_at?: string
        }
        Update: {
          id?: string
          code?: string
          name?: string
          description?: string | null
          order?: number
          created_at?: string
        }
      }
      skills: {
        Row: {
          id: string
          code: string
          name_de: string
          name_en: string
          created_at: string
        }
        Insert: {
          id?: string
          code: string
          name_de: string
          name_en: string
          created_at?: string
        }
        Update: {
          id?: string
          code?: string
          name_de?: string
          name_en?: string
          created_at?: string
        }
      }
      test_modules: {
        Row: {
          id: string
          level_id: string
          skill_id: string
          title: string
          description: string | null
          price_kes: number
          question_count: number
          duration_minutes: number
          is_active: boolean
          exam_format: ExamFormat
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          level_id: string
          skill_id: string
          title: string
          description?: string | null
          price_kes: number
          question_count: number
          duration_minutes: number
          is_active?: boolean
          exam_format?: ExamFormat
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          level_id?: string
          skill_id?: string
          title?: string
          description?: string | null
          price_kes?: number
          question_count?: number
          duration_minutes?: number
          is_active?: boolean
          exam_format?: ExamFormat
          created_at?: string
          updated_at?: string
        }
      }
      purchases: {
        Row: {
          id: string
          user_id: string
          test_module_id: string
          amount_kes: number
          mpesa_receipt_number: string | null
          phone_number: string
          status: 'pending' | 'completed' | 'failed' | 'refunded'
          created_at: string
          completed_at: string | null
        }
        Insert: {
          id?: string
          user_id: string
          test_module_id: string
          amount_kes: number
          mpesa_receipt_number?: string | null
          phone_number: string
          status?: 'pending' | 'completed' | 'failed' | 'refunded'
          created_at?: string
          completed_at?: string | null
        }
        Update: {
          id?: string
          user_id?: string
          test_module_id?: string
          amount_kes?: number
          mpesa_receipt_number?: string | null
          phone_number?: string
          status?: 'pending' | 'completed' | 'failed' | 'refunded'
          created_at?: string
          completed_at?: string | null
        }
      }
      test_attempts: {
        Row: {
          id: string
          user_id: string
          test_module_id: string | null
          is_placement_test: boolean
          started_at: string
          completed_at: string | null
          score: number | null
          max_score: number
          percentage: number | null
          result_level: string | null
        }
        Insert: {
          id?: string
          user_id: string
          test_module_id?: string | null
          is_placement_test?: boolean
          started_at?: string
          completed_at?: string | null
          score?: number | null
          max_score: number
          percentage?: number | null
          result_level?: string | null
        }
        Update: {
          id?: string
          user_id?: string
          test_module_id?: string | null
          is_placement_test?: boolean
          started_at?: string
          completed_at?: string | null
          score?: number | null
          max_score?: number
          percentage?: number | null
          result_level?: string | null
        }
      }
      questions: {
        Row: {
          id: string
          test_module_id: string
          question_text: string
          question_type: 'multiple_choice' | 'fill_blank' | 'essay' | 'audio' | 'speaking'
          question_audio_url: string | null
          question_image_url: string | null
          audio_url: string | null
          options: any | null
          correct_answer: string
          explanation: string | null
          points: number
          order: number
          exam_part: number | null
          audio_script: string | null
          audio_plays_max: number | null
          task_type: ExamTaskType | null
          word_limit_min: number | null
          word_limit_max: number | null
          leitpunkte: Json | null
          rubric: InstructorRubric | null
          audio_source_id: string | null
          created_at: string
        }
        Insert: {
          id?: string
          test_module_id: string
          question_text: string
          question_type: 'multiple_choice' | 'fill_blank' | 'essay' | 'audio' | 'speaking'
          question_audio_url?: string | null
          question_image_url?: string | null
          audio_url?: string | null
          options?: any | null
          correct_answer: string
          explanation?: string | null
          points?: number
          order: number
          exam_part?: number | null
          audio_script?: string | null
          audio_plays_max?: number | null
          task_type?: ExamTaskType | null
          word_limit_min?: number | null
          word_limit_max?: number | null
          leitpunkte?: Json | null
          rubric?: InstructorRubric | null
          audio_source_id?: string | null
          created_at?: string
        }
        Update: {
          id?: string
          test_module_id?: string
          question_text?: string
          question_type?: 'multiple_choice' | 'fill_blank' | 'essay' | 'audio' | 'speaking'
          question_audio_url?: string | null
          question_image_url?: string | null
          audio_url?: string | null
          options?: any | null
          correct_answer?: string
          explanation?: string | null
          points?: number
          order?: number
          exam_part?: number | null
          audio_script?: string | null
          audio_plays_max?: number | null
          task_type?: ExamTaskType | null
          word_limit_min?: number | null
          word_limit_max?: number | null
          leitpunkte?: Json | null
          rubric?: InstructorRubric | null
          audio_source_id?: string | null
          created_at?: string
        }
      }
      audio_assets: {
        Row: {
          id: string
          storage_path: string
          source_url: string | null
          license: AudioLicense
          attribution_text: string | null
          cefr_level: string | null
          duration_sec: number | null
          transcript: string | null
          created_at: string
        }
        Insert: {
          id?: string
          storage_path: string
          source_url?: string | null
          license: AudioLicense
          attribution_text?: string | null
          cefr_level?: string | null
          duration_sec?: number | null
          transcript?: string | null
          created_at?: string
        }
        Update: {
          id?: string
          storage_path?: string
          source_url?: string | null
          license?: AudioLicense
          attribution_text?: string | null
          cefr_level?: string | null
          duration_sec?: number | null
          transcript?: string | null
          created_at?: string
        }
      }
      test_answers: {
        Row: {
          id: string
          test_attempt_id: string
          question_id: string
          user_answer: string
          is_correct: boolean | null
          points_earned: number | null
          graded_by: string | null
          graded_at: string | null
          instructor_feedback: string | null
          created_at: string
        }
        Insert: {
          id?: string
          test_attempt_id: string
          question_id: string
          user_answer: string
          is_correct?: boolean | null
          points_earned?: number | null
          graded_by?: string | null
          graded_at?: string | null
          instructor_feedback?: string | null
          created_at?: string
        }
        Update: {
          id?: string
          test_attempt_id?: string
          question_id?: string
          user_answer?: string
          is_correct?: boolean | null
          points_earned?: number | null
          graded_by?: string | null
          graded_at?: string | null
          instructor_feedback?: string | null
          created_at?: string
        }
      }
      placement_test_questions: {
        Row: {
          id: string
          level_id: string
          question_text: string
          options: Json
          correct_answer: string
          points: number
          order: number
          created_at: string
        }
        Insert: {
          id?: string
          level_id: string
          question_text: string
          options: Json
          correct_answer: string
          points?: number
          order: number
          created_at?: string
        }
        Update: {
          id?: string
          level_id?: string
          question_text?: string
          options?: Json
          correct_answer?: string
          points?: number
          order?: number
          created_at?: string
        }
      }
    }
  }
}
