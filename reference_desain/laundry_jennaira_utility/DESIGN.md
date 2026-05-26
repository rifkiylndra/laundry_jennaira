---
name: Laundry Jennaira Utility
colors:
  surface: '#f7f9fb'
  surface-dim: '#d8dadc'
  surface-bright: '#f7f9fb'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f2f4f6'
  surface-container: '#eceef0'
  surface-container-high: '#e6e8ea'
  surface-container-highest: '#e0e3e5'
  on-surface: '#191c1e'
  on-surface-variant: '#44474f'
  inverse-surface: '#2d3133'
  inverse-on-surface: '#eff1f3'
  outline: '#747780'
  outline-variant: '#c4c6d0'
  surface-tint: '#455e91'
  primary: '#00183f'
  on-primary: '#ffffff'
  primary-container: '#0f2d5e'
  on-primary-container: '#7d96cd'
  inverse-primary: '#aec6ff'
  secondary: '#0051d5'
  on-secondary: '#ffffff'
  secondary-container: '#316bf3'
  on-secondary-container: '#fefcff'
  tertiary: '#001f0a'
  on-tertiary: '#ffffff'
  tertiary-container: '#003717'
  on-tertiary-container: '#5ba66d'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#d8e2ff'
  primary-fixed-dim: '#aec6ff'
  on-primary-fixed: '#001a42'
  on-primary-fixed-variant: '#2c4678'
  secondary-fixed: '#dbe1ff'
  secondary-fixed-dim: '#b4c5ff'
  on-secondary-fixed: '#00174b'
  on-secondary-fixed-variant: '#003ea8'
  tertiary-fixed: '#a6f4b5'
  tertiary-fixed-dim: '#8bd79b'
  on-tertiary-fixed: '#00210b'
  on-tertiary-fixed-variant: '#005226'
  background: '#f7f9fb'
  on-background: '#191c1e'
  surface-variant: '#e0e3e5'
  income-green: '#166534'
  expense-red: '#991B1B'
  warning-orange: '#9A3412'
  text-primary: '#374151'
  text-secondary: '#64748B'
  surface-card: '#FFFFFF'
typography:
  headline-lg:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 36px
  headline-md:
    fontFamily: Inter
    fontSize: 22px
    fontWeight: '600'
    lineHeight: 28px
  title-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 24px
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-lg:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '500'
    lineHeight: 20px
    letterSpacing: 0.1px
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.5px
  numeric-display:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  edge-margin: 1rem
  gutter-md: 1rem
  stack-sm: 0.5rem
  stack-md: 1rem
  stack-lg: 1.5rem
---

## Brand & Style

The design system is rooted in a **Corporate / Modern** aesthetic with a heavy emphasis on **utilitarian efficiency**. Designed for the fast-paced environment of a laundry service, the UI prioritizes speed of data entry and legibility over decorative elements. It follows the Material Design 3 (M3) framework to ensure familiarity and platform-native performance.

The brand personality is **professional, trustworthy, and systematic**. Every design decision is governed by "Ruthless Prioritization," ensuring that the interface remains uncluttered even during peak operational hours. The emotional response is one of reliability—users should feel that the system is an extension of their physical workflow, providing clarity on revenue and order status at a glance.

**Key Visual Principles:**
- **High Information Density:** Controlled whitespace that allows for more data visibility without compromising touch targets.
- **Functional Color Coding:** Colors are used as semantic signals for status and financial health.
- **Utilitarian Components:** Buttons and inputs are prominent and easy to interact with in varied lighting conditions.

## Colors

The color palette is strictly functional, utilizing a deep navy primary for authority and a vibrant blue for interaction. 

- **Primary (#0F2D5E):** Reserved for high-level structure—AppBars, headers, and the most critical primary actions.
- **Accent/Secondary (#2563EB):** Used for navigation cues, active tab states, and secondary buttons.
- **Semantic Colors:** Green, Red, and Orange are used strictly for financial status (Income/Expense) and operational status (Selesai/Siap Diambil). 
- **Neutral Palette:** The background uses a cool-toned off-white to reduce eye strain, while text colors are kept within a specific grey range to maintain contrast without the harshness of pure black.

**Color Application:**
- Backgrounds use the Neutral color.
- Container surfaces (Cards/Sheets) use the "surface-card" White.
- Use "text-primary" for all user input and main headers; "text-secondary" for labels and metadata.

## Typography

This design system utilizes **Inter** for all typographic levels to ensure maximum legibility and a modern, professional feel. The scale is built on a modular rhythm that prioritizes clear hierarchy in data-heavy screens.

- **Headlines:** Used for screen titles in AppBars and major section headings.
- **Titles:** Used for card headings and modal titles.
- **Body:** Standardized for description text and customer notes.
- **Labels:** Crucial for the "utilitarian" feel; used for small metadata, timestamps, and form field hints.
- **Numeric Display:** A specialized weight and size for total prices and financial summaries to ensure they are the first thing a user sees.

**Text Color Implementation:**
- Use `text-primary` for all headlines, titles, and body-lg.
- Use `text-secondary` for body-md and all labels.

## Layout & Spacing

The layout follows a **fluid grid** model optimized for mobile handsets. We utilize a generous padding strategy to prevent accidental taps, which is critical in active work environments like a laundry shop.

**Layout Model:**
- **Margins:** A consistent 16px (1rem) margin on the left and right edges of all screens.
- **Vertical Spacing:** Elements are stacked using an 8px base unit. 
    - 8px for related elements (Label + Input).
    - 16px for unrelated elements or card spacing.
    - 24px for separating major sections (Hero Section vs. Chart Section).
- **Safe Areas:** Adhere strictly to system safe areas for bottom navigation and top AppBars.

**Breakpoints:**
- **Mobile (< 600px):** Single column layout. Cards span the full width minus margins.
- **Tablet (> 600px):** Dashboard summary cards may reflow into a 2-column or 3-column grid, but list items remain full width for readability.

## Elevation & Depth

This design system uses a combination of **Tonal Layers** and **Ambient Shadows** to create hierarchy without visual noise.

- **Background:** The flat `#F8FAFC` base provides a neutral foundation.
- **Level 1 (Cards):** All primary content containers (Order cards, Transaction items) use a white surface with a "Soft Shadow"—a very low-opacity (4-8%), highly diffused black shadow with no offset. This makes the cards feel like they are floating slightly above the background.
- **Level 2 (Modals/Bottom Sheets):** These use a higher elevation with a darker scrim (scrim opacity: 40%) to focus the user on data entry tasks.
- **Buttons:** Primary buttons use a subtle inner glow or a very small drop shadow to indicate interactivity, while secondary buttons remain flat with a border or tonal background.

## Shapes

The shape language is **Rounded**, following the modern Material 3 specification. This softens the utilitarian nature of the app, making it feel approachable.

- **Standard Containers:** Cards, Text Fields, and typical buttons use a 0.5rem (8px) radius.
- **Large Components:** Bottom sheets and large dashboard banners use "rounded-lg" (1rem/16px) for the top corners.
- **Status Chips:** Use a full pill-shape (circular ends) to distinguish them from interactive buttons.
- **FAB:** The Floating Action Button follows the M3 standard (slightly rounded square/container) with a 1rem radius.

## Components

### Buttons
- **Primary:** Background `#0F2D5E`, Text `White`. Large height (min 48px) for ease of touch.
- **Secondary:** Background `#F8FAFC`, Border 1px `#2563EB`, Text `#2563EB`. 
- **FAB:** Background `#0F2D5E`, Icon `White`. Located in the bottom-right for primary actions (Add Order/Transaction).

### Status Chips
- Use the semantic colors (Green, Red, Orange) with a 12% opacity background of the same color. 
- Text should be the full-saturation hex code for high contrast.

### Input Fields
- **Style:** Outlined Material 3 text fields.
- **Focus State:** Border color shifts to `#2563EB`.
- **Labels:** `text-secondary` at 12px when floating.

### Cards (OrderCard / SummaryCard)
- **Background:** `#FFFFFF`.
- **Shadow:** 0px 2px 8px rgba(0, 0, 0, 0.05).
- **Padding:** 16px internally.

### Inventory Progress Bar
- **Normal:** Track `#F1F5F9`, Indicator `#2563EB`.
- **Low Stock:** Indicator and card border shift to `#991B1B` (Expense/Red).

### Visual Stepper (Order Detail)
- Use a horizontal line connector. Completed steps use `#0F2D5E` with a checkmark. Active steps use a `#2563EB` pulse. Upcoming steps use `#64748B`.