# DeutschPrep Implementation Plan

## Phase 1: Setup & Foundation (Week 1)

### 1.1 Supabase Project Setup
- [ ] Create Supabase project
- [ ] Set up environment variables
- [ ] Install Supabase client library
- [ ] Configure authentication

### 1.2 Database Schema
- [ ] Create all tables (see DATABASE_SCHEMA.md)
- [ ] Set up Row Level Security policies
- [ ] Create database functions for complex queries
- [ ] Seed initial data (levels, skills)

### 1.3 Authentication Setup
- [ ] Implement sign up flow
- [ ] Implement login flow
- [ ] Implement password reset
- [ ] Add protected routes
- [ ] Create auth context/hooks

## Phase 2: Core User Features (Week 2-3)

### 2.1 Placement Test
- [ ] Create placement test UI
- [ ] Implement question navigation
- [ ] Add timer functionality
- [ ] Calculate results and determine level
- [ ] Show results page with recommendations
- [ ] Store test attempts in database

### 2.2 Browse & View Tests
- [ ] Level detail pages (already have UI)
- [ ] Test module cards with purchase status
- [ ] Test preview/details modal
- [ ] User dashboard showing purchased tests

### 2.3 Test Taking Interface
- [ ] Question display component
- [ ] Answer input (multiple choice, text, etc.)
- [ ] Progress indicator
- [ ] Submit test functionality
- [ ] Results page with score breakdown
- [ ] Review answers with explanations

## Phase 3: Payment Integration (Week 3-4)

### 3.1 M-Pesa Integration
- [ ] Set up Daraja API credentials
- [ ] Create Supabase Edge Function for STK Push
- [ ] Implement payment initiation flow
- [ ] Create webhook endpoint for payment confirmation
- [ ] Handle payment status updates
- [ ] Send confirmation emails

### 3.2 Purchase Flow
- [ ] Payment modal/page
- [ ] Phone number input with validation
- [ ] Payment status polling
- [ ] Success/failure handling
- [ ] Unlock purchased content

## Phase 4: Admin Dashboard (Week 4-5)

### 4.1 Admin Authentication
- [ ] Admin role checking
- [ ] Protected admin routes
- [ ] Admin layout/navigation

### 4.2 Content Management
- [ ] Manage test modules (CRUD)
- [ ] Manage questions (CRUD)
- [ ] Bulk question import (CSV/JSON)
- [ ] Question preview
- [ ] Manage grammar topics

### 4.3 User Management
- [ ] View all users
- [ ] User details & purchase history
- [ ] Search & filter users
- [ ] Manual access grants (for testing)

### 4.4 Analytics & Reports
- [ ] Dashboard overview (users, revenue, tests taken)
- [ ] Revenue reports
- [ ] Popular tests
- [ ] User engagement metrics
- [ ] Export data functionality

## Phase 5: Polish & Launch (Week 5-6)

### 5.1 User Experience
- [ ] Loading states
- [ ] Error handling
- [ ] Toast notifications
- [ ] Responsive design fixes
- [ ] Accessibility improvements

### 5.2 Email Notifications
- [ ] Welcome email
- [ ] Purchase confirmation
- [ ] Test completion
- [ ] Password reset

### 5.3 Testing & QA
- [ ] End-to-end testing
- [ ] Payment flow testing (sandbox)
- [ ] Cross-browser testing
- [ ] Mobile testing
- [ ] Security audit

### 5.4 Deployment
- [ ] Set up production Supabase project
- [ ] Configure production M-Pesa
- [ ] Deploy frontend (Vercel/Netlify)
- [ ] Set up monitoring
- [ ] Create backup strategy

## Technology Stack

### Frontend
- React 18
- TypeScript
- React Router
- TanStack Query (React Query)
- Supabase JS Client
- Tailwind CSS + shadcn/ui

### Backend
- Supabase (PostgreSQL)
- Supabase Auth
- Supabase Storage (for audio files)
- Supabase Edge Functions (for M-Pesa)

### Payment
- M-Pesa Daraja API
- Supabase Edge Functions for webhooks

### Deployment
- Frontend: Vercel or Netlify
- Backend: Supabase (managed)

## Environment Variables Needed

```env
# Supabase
VITE_SUPABASE_URL=
VITE_SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY= # Server-side only

# M-Pesa (Daraja API)
MPESA_CONSUMER_KEY=
MPESA_CONSUMER_SECRET=
MPESA_SHORTCODE=
MPESA_PASSKEY=
MPESA_CALLBACK_URL=
MPESA_ENVIRONMENT= # sandbox or production
```

## Next Steps

1. Create Supabase project
2. Run database migrations
3. Install dependencies
4. Set up authentication
5. Build placement test
6. Integrate M-Pesa
7. Create admin dashboard
