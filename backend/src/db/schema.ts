import { pgTable, serial, varchar, integer, boolean, smallint, timestamp } from 'drizzle-orm/pg-core'
import { relations } from 'drizzle-orm'

export const cardSets = pgTable('card_sets', {
  id: serial('id').primaryKey(),
  code: varchar('code', { length: 10 }).notNull().unique(),
  name: varchar('name', { length: 255 }).notNull(),
  orderIndex: integer('order_index').notNull(),
})

export const cards = pgTable('cards', {
  id: serial('id').primaryKey(),
  name: varchar('name', { length: 255 }).notNull(),
  cardCode: varchar('card_code', { length: 20 }).notNull().unique(),
  setId: integer('set_id').notNull().references(() => cardSets.id),
  wikiUrl: varchar('wiki_url', { length: 500 }),
  passcode: integer('passcode'),
})

export const collection = pgTable('collection', {
  id: serial('id').primaryKey(),
  cardId: integer('card_id').notNull().references(() => cards.id).unique(),
  owned: boolean('owned').notNull().default(false),
  edition: smallint('edition'),
  condition: smallint('condition'),
  isUltimate: boolean('is_ultimate').notNull().default(false),
  notes: varchar('notes', { length: 1000 }),
})

export const cardPhotos = pgTable('card_photos', {
  id: serial('id').primaryKey(),
  cardId: integer('card_id').notNull().references(() => cards.id),
  filename: varchar('filename', { length: 255 }).notNull(),
  createdAt: timestamp('created_at').notNull().defaultNow(),
})

export const cardSetsRelations = relations(cardSets, ({ many }) => ({
  cards: many(cards),
}))

export const cardsRelations = relations(cards, ({ one, many }) => ({
  cardSet: one(cardSets, { fields: [cards.setId], references: [cardSets.id] }),
  collection: one(collection, { fields: [cards.id], references: [collection.cardId] }),
  photos: many(cardPhotos),
}))

export const collectionRelations = relations(collection, ({ one }) => ({
  card: one(cards, { fields: [collection.cardId], references: [cards.id] }),
}))

export const cardPhotosRelations = relations(cardPhotos, ({ one }) => ({
  card: one(cards, { fields: [cardPhotos.cardId], references: [cards.id] }),
}))
