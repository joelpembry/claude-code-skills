# Synesis — Framework IP Compliance Assessment

**Date:** 2026-07-24
**Trigger:** Pre-Day 5 compliance gate
**Status:** ⚠️ 1 CRITICAL finding, 2 MODERATE, 3 SAFE

---

## Framework-by-Framework IP Analysis

### 1. "Myers-Briggs" / "MBTI" — 🔴 CRITICAL — MUST RENAME

| Item | Status |
|---|---|
| **Trademark holder** | Myers & Briggs Foundation |
| **Publisher/enforcer** | The Myers-Briggs Company (exclusive worldwide publisher since 1975) |
| **Registration** | ® registered in US and other countries |
| **Our usage** | Self-reported intake (mbti_ei/sn/tf/jp columns) — NOT the genuine MBTI® instrument |
| **What we're doing** | Collecting Jungian type preferences via in-house questions, labeling results as "Myers-Briggs" |

**Legal risk:** HIGH. Using "Myers-Briggs" or "MBTI" to describe a non-genuine MBTI product is explicitly prohibited by The Myers-Briggs Company. Their IP guidelines state this is "not correct or legally appropriate" and "some online assessments are already infringing." We are NOT certified practitioners, NOT administering the genuine instrument, and NOT licensed.

**Required trademark usage (if we kept the name — which we should NOT):**
- ® symbol at most prominent use and first use on every web page
- Mandatory acknowledgement: "Myers-Briggs Type Indicator, Myers-Briggs, and MBTI are trademarks or registered trademarks of Myers & Briggs Foundation in the United States and other countries."
- Adjective-only rule: "MBTI® instrument" not "MBTI"
- Must only refer to genuine MBTI products

**RECOMMENDATION:** Rename immediately. Options:
- "Cognitive Type" (neutral, descriptive, no IP risk)
- "16 Typologies" (describes what it measures without referencing the trademark)
- "Jungian Type" (references the underlying theory, which is public domain)

---

### 2. "Big Five" / "OCEAN" — 🟢 SAFE

| Item | Status |
|---|---|
| **IP status** | Scientific concepts — NOT copyrightable |
| **Trait names** | Openness, Conscientiousness, Extraversion, Agreeableness, Neuroticism — public domain |
| **Our usage** | Self-reported sliders (PersonalityIntakeV2.tsx) — NOT the copyrighted NEO-PI-R |
| **Public domain alternative** | IPIP (International Personality Item Pool) — fully public domain, any use permitted |

**Risk:** NONE. The OCEAN model and trait names are scientific facts. Our intake uses in-house questions, not the NEO-PI-R. We should verify our `telos_assessment_libraries` Big Five entries use IPIP-derived or in-house narrative blocks, not NEO-PI-R content.

**Recommendation:** Document in README that Big Five scoring is based on public-domain IPIP items and the OCEAN scientific model. Cite Lewis Goldberg's IPIP as source.

---

### 3. "Enneagram" — 🟡 MODERATE RISK

| Item | Status |
|---|---|
| **IP status** | Concept widely used; Ichazo's specific label/figure arrangement was found copyrightable (Arica v. Palmer, US Court of Appeals) |
| **Fair use** | Educational/scholarly use of Enneagram concepts found to be fair use even in commercial books |
| **Our usage** | Self-reported type + wing (enneagram_type, enneagram_wing columns), in-house assessment questions |

**Risk:** MODERATE. The Enneagram concept itself is in the public domain, but specific copyrighted diagrams and label arrangements (Ichazo/Arica Institute) should not be reproduced. Our intake asks self-report questions and stores numeric type/wing — no specific copyrighted content appears to be in use.

**Recommendation:** Use the term "Enneagram" freely but avoid reproducing any specific copyrighted Enneagram diagrams from Arica Institute publications. Our in-house questions and numeric type system are fine.

---

### 4. "DISC" — 🟡 MODERATE RISK

| Item | Status |
|---|---|
| **IP status** | Marston's DISC theory (1928) — PUBLIC DOMAIN |
| **Wiley trademark** | "Everything DiSC" and specific Wiley materials — HEAVILY PROTECTED |
| **Our usage** | Self-reported D/I/S/C scores, in-house questions |

**Risk:** MODERATE. The underlying DISC theory by William Moulton Marston is nearly 100 years old and firmly in the public domain. However, Wiley aggressively protects "Everything DiSC" and their specific assessment materials. We must NEVER use "Everything DiSC" or reference Wiley. Our generic "DISC" usage based on Marston's theory is defensible.

**Recommendation:** Add a small attribution: "Based on the DISC behavior model developed by William Moulton Marston." This distinguishes us from Wiley's "Everything DiSC" product and anchors us to the public-domain theory.

---

### 5. "Western Zodiac" — 🟢 SAFE

Public domain. Astrological concepts are thousands of years old. No IP concerns.

---

### 6. "Eastern Zodiac" — 🟢 SAFE

Public domain. No IP concerns.

---

## Assessment Library Audit

The `telos_assessment_libraries` table (seeded Phase 3F, promoted to v2) contains narrative blocks for all 6 frameworks. These were described as:
- MBTI, DISC: AI-authored from PDF specs (Sam reviewing)
- Big Five, Enneagram: AI-authored from PDF specs (narratives provisional, Sam approved as-is in WS-F)
- Western/Eastern Zodiac: from Sam's zip file

**⚠️ Unknown risk:** We have not verified the source provenance of the PDF specs used to generate these libraries. If the MBTI narratives were generated from copyrighted MBTI® materials, that's a derivative work concern. If generated from public-domain descriptions of Jungian cognitive functions, they're safe.

---

## Why Governance Didn't Flag This

The build pipeline has no automated IP/trademark compliance check. The 5-Phase Overhaul documents were authored by Sam and reviewed by Joel — neither flagged trademark concerns. The governance stack (OptimoCodex/OptimoCortex/OptimoAgile) has no compliance gate for third-party trademark usage in UI labels.

**Process gap:** There is no automated or manual step in the build pipeline that checks product labels, framework names, or library content against registered trademark databases or copyright registries.

---

## Immediate Actions Required

| Priority | Action | Timeline |
|---|---|---|
| 🔴 P1 | Rename "Myers-Briggs" → "Cognitive Type" or "16 Typologies" across ALL user-visible surfaces (Landing.tsx Framework card, internal labels, edge function prompts, tour steps) | Before Day 5 |
| 🔴 P1 | Add IP compliance section to README documenting each framework's IP status and our usage rights | Before Day 5 |
| 🟡 P2 | Verify `telos_assessment_libraries` MBTI entries use public-domain Jungian descriptions, NOT copyrighted MBTI® materials | Before Day 5 |
| 🟡 P2 | Add DISC attribution: "Based on the DISC model by William Moulton Marston" | Day 5 |
| 🟡 P2 | Add compliance gate to build governance: trademark/copyright check before any new brand label goes live | This week |
| 🟢 P3 | Document Big Five as IPIP/public-domain based in README | Day 5 |
| 🟢 P3 | Audit `telos_assessment_libraries` Big Five entries for NEO-PI-R content | This week |
