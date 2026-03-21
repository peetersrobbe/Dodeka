// ============================================================
// DODEKA SPORT – Supabase Configuration
// Replace the two placeholder values below with your own keys
// from: https://app.supabase.com → Project Settings → API
//
// IMPORTANT: The ANON key is safe to commit.
//            NEVER put the SERVICE_ROLE key in this file.
// ============================================================

const SUPABASE_URL  = 'https://ntxbgiccwdmsmsuhaicc.supabase.co';   // e.g. https://xyzabc.supabase.co
const SUPABASE_ANON = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im50eGJnaWNjd2Rtc21zdWhhaWNjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzQxMTM3ODMsImV4cCI6MjA4OTY4OTc4M30.iGiaocIQMCKSWW49zvOdkeg9ZAiiJDkPRkiVeXVSAV0';        // starts with eyJ…

const supabaseClient = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON);
