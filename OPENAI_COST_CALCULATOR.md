# OpenAI Cost Calculator - Accurate Breakdown

## Your Platform Setup

- **Total questions**: 140
- **Multiple choice**: 100 (no AI cost)
- **Writing questions**: 20 (AI evaluation)
- **Speaking questions**: 20 (Whisper + AI evaluation)

## OpenAI Pricing (March 2026)

### GPT-4o-mini
- Input: $0.150 per 1M tokens
- Output: $0.600 per 1M tokens

### Whisper
- $0.006 per minute of audio

## Detailed Cost Calculation

### Writing Question Evaluation

**Typical prompt size**:
- System prompt: ~400 tokens
- Question text: ~50 tokens
- Student answer: ~100 tokens (A1) to ~300 tokens (B2)
- **Total input**: ~550-750 tokens (avg: 650 tokens)

**Typical response size**:
- JSON evaluation with scores and feedback: ~400 tokens

**Cost per writing question**:
- Input: 650 tokens × $0.150 / 1M = $0.0000975
- Output: 400 tokens × $0.600 / 1M = $0.0002400
- **Total: ~$0.00034 per question**

**20 writing questions**: 20 × $0.00034 = **$0.0068**

### Speaking Question Evaluation

**Step 1: Whisper Transcription**
- Average audio length: 30-60 seconds (avg: 45 seconds = 0.75 minutes)
- Cost: 0.75 × $0.006 = **$0.0045 per audio**

**Step 2: Text Evaluation** (same as writing)
- Cost: **$0.00034 per question**

**Total per speaking question**: $0.0045 + $0.00034 = **$0.00484**

**20 speaking questions**: 20 × $0.00484 = **$0.0968**

## Total Cost Per User

| Component | Questions | Cost per Q | Total |
|-----------|-----------|------------|-------|
| Multiple Choice | 100 | $0 | $0 |
| Writing | 20 | $0.00034 | $0.0068 |
| Speaking | 20 | $0.00484 | $0.0968 |
| **TOTAL** | **140** | - | **$0.1036** |

## How Long Will $20 Last?

### Number of Users
$20 ÷ $0.1036 per user = **~193 users**

### By Usage Scenario

#### Scenario 1: All Users Complete Everything
- **193 complete users** (all 140 questions)
- Duration: Depends on your user acquisition rate

#### Scenario 2: Typical Usage (70% completion)
- Some users don't finish all tests
- Effective cost per user: ~$0.073
- **~274 users** can start tests

#### Scenario 3: Only Speaking/Writing Tests
If users only take the AI-evaluated tests:
- Cost per test module: ~$0.026 (5 questions)
- **~770 test modules**

## Real-World Projections

### Conservative Estimate (High Usage)
- **193 users** complete all tests
- If you get 10 users/day: **19 days**
- If you get 5 users/day: **39 days** (~5 weeks)
- If you get 2 users/day: **97 days** (~3 months)

### Realistic Estimate (70% completion)
- **274 users** start tests
- If you get 10 users/day: **27 days**
- If you get 5 users/day: **55 days** (~8 weeks)
- If you get 2 users/day: **137 days** (~4.5 months)

## Revenue vs Cost

### If you charge KES 500 (~$5) per test:

| Users | Revenue | AI Cost | Profit | Margin |
|-------|---------|---------|--------|--------|
| 50 | $250 | $5.18 | $244.82 | 98% |
| 100 | $500 | $10.36 | $489.64 | 98% |
| 193 | $965 | $20.00 | $945.00 | 98% |

**Your profit margin is 98%!** (Much better than the 71% I calculated before)

## Recommendations

### For Testing Phase
- **Start with $20**: Covers 193 users
- Monitor usage for first 50 users
- Adjust pricing if needed

### For Launch
- **$50**: Covers ~483 users (1-2 months)
- **$100**: Covers ~965 users (2-4 months)
- **$200**: Covers ~1,930 users (4-6 months)

### Set Billing Alerts
In OpenAI Dashboard, set alerts at:
- $10 (50% of $20)
- $15 (75% of $20)
- $18 (90% of $20)

## Cost Optimization Tips

### If costs are too high:

1. **Reduce prompt size**: Shorter system prompts (saves ~20%)
2. **Cache common prompts**: Reuse evaluations for similar answers
3. **Batch processing**: Evaluate multiple questions together
4. **Limit audio length**: Cap speaking responses at 60 seconds
5. **Use gpt-3.5-turbo**: 10x cheaper but lower quality

### Current Setup is Optimal
Your current setup using gpt-4o-mini is already cost-effective:
- High quality evaluations
- 98% profit margin
- Reasonable cost per user

## Monthly Cost Projections

### Low Traffic (50 users/month)
- Cost: $5.18/month
- Revenue: $250/month
- Profit: $244.82/month

### Medium Traffic (200 users/month)
- Cost: $20.72/month
- Revenue: $1,000/month
- Profit: $979.28/month

### High Traffic (500 users/month)
- Cost: $51.80/month
- Revenue: $2,500/month
- Profit: $2,448.20/month

### Very High Traffic (1,000 users/month)
- Cost: $103.60/month
- Revenue: $5,000/month
- Profit: $4,896.40/month

## Summary

**$20 will last for approximately:**
- **193 complete users** (100% completion)
- **274 users** (70% completion - more realistic)
- **19-137 days** depending on user acquisition rate

**Key Takeaway**: At $0.10 per user and $5 revenue per user, your AI costs are negligible. You have a 98% profit margin!

## Action Items

1. ✅ Add $20 to start (covers 193 users)
2. ✅ Set billing alerts at $10, $15, $18
3. ✅ Monitor usage after first 50 users
4. ✅ Add more credits when you hit $15 (don't wait until $20)
5. ✅ Plan to add $50-100 for launch month

---

**Bottom Line**: $20 is plenty for testing and initial launch. You'll likely need to add more credits due to success, not because you're running out! 🚀
