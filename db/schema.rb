# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140906022318) do

  create_table "attendances", force: true do |t|
    t.integer  "training_class_id"
    t.date     "attendance_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dictation_scores", force: true do |t|
    t.integer  "student_id"
    t.integer  "dictation_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dictations", force: true do |t|
    t.integer  "passing_line"
    t.date     "execute_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "training_class_id"
  end

  create_table "employees", force: true do |t|
    t.integer  "user_id"
    t.boolean  "admin",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "examinations", force: true do |t|
    t.integer  "training_class_id"
    t.integer  "test_paper_id"
    t.date     "test_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "homework_finishes", force: true do |t|
    t.integer  "homework_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "homeworks", force: true do |t|
    t.string   "title"
    t.date     "distribution_date"
    t.date     "submit_date"
    t.string   "subject_type"
    t.integer  "teacher_id"
    t.integer  "training_class_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.integer  "index_number"
    t.integer  "difficulty"
    t.integer  "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "score_details", force: true do |t|
    t.string   "answer_result"
    t.integer  "score_number"
    t.integer  "simulate_test_score_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scores", force: true do |t|
    t.integer  "examination_id"
    t.integer  "student_id"
    t.integer  "final_score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "course_a_score"
    t.integer  "course_b_score"
    t.integer  "course_c_score"
    t.integer  "course_d_score"
    t.integer  "stat_01"
    t.integer  "stat_02"
    t.integer  "stat_03"
    t.integer  "stat_04"
    t.integer  "stat_05"
    t.integer  "stat_06"
    t.integer  "stat_07"
    t.integer  "stat_08"
    t.integer  "stat_09"
    t.integer  "stat_10"
    t.integer  "stat_11"
    t.integer  "stat_12"
    t.integer  "stat_13"
    t.integer  "stat_14"
    t.integer  "stat_15"
    t.integer  "stat_16"
    t.integer  "hard_level1"
    t.integer  "hard_level2"
    t.integer  "hard_level3"
    t.integer  "hard_level4"
    t.integer  "hard_level5"
  end

  create_table "sections", force: true do |t|
    t.string   "name"
    t.integer  "test_paper_id"
    t.string   "course_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "questions_count", default: 0
  end

  create_table "student_attendances", force: true do |t|
    t.integer  "student_id"
    t.integer  "attendance_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.integer  "user_id"
    t.integer  "entry_score_sat"
    t.integer  "target_score_sat"
    t.integer  "entry_score_toefl"
    t.integer  "target_score_toefl"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "parent_name"
    t.string   "parent_tel"
    t.string   "school"
    t.string   "qq_number"
    t.string   "tinypost_number"
    t.integer  "entry_sat_cr"
    t.integer  "entry_sat_math"
    t.integer  "entry_sat_writing"
    t.integer  "target_sat_cr"
    t.integer  "target_sat_math"
    t.integer  "target_sat_writing"
    t.integer  "entry_toefl_reading"
    t.integer  "entry_toefl_listen"
    t.integer  "entry_toefl_say"
    t.integer  "entry_toefl_writing"
    t.integer  "target_toefl_reading"
    t.integer  "target_toefl_listen"
    t.integer  "target_toefl_say"
    t.integer  "target_toefl_writing"
    t.integer  "school_rank"
    t.integer  "total_toefl_times"
    t.integer  "total_sat_times"
    t.integer  "expect_toefl_times"
    t.integer  "expect_sat_exam_month_5"
    t.integer  "expect_sat_exam_month_6"
    t.integer  "expect_sat_exam_month_10"
    t.integer  "expect_sat_exam_month_11"
    t.integer  "expect_sat_exam_month_12"
    t.string   "identify_card"
  end

  create_table "students_test_papers", id: false, force: true do |t|
    t.integer  "student_id"
    t.integer  "test_paper_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students_training_classes", id: false, force: true do |t|
    t.integer  "student_id"
    t.integer  "training_class_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", force: true do |t|
    t.string   "name"
    t.integer  "teacher_id"
    t.integer  "training_class_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teachers", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "test_papers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sections_count", default: 0
    t.string   "exam_type"
  end

  create_table "text_books", force: true do |t|
    t.string   "name"
    t.string   "exam_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "training_classes", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "master_teacher_id"
    t.string   "exam_type",         default: "SAT"
    t.integer  "text_book_id"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.string   "password",     default: ""
    t.string   "role_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
