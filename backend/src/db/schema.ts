import { pgTable, serial, varchar, integer, boolean, smallint, timestamp } from 'drizzle-orm/pg-core'
import { relations } from 'drizzle-orm'

export const users = pgTable('users', {
  id: serial('id').primaryKey(),
  email: varchar('email', { length: 255 }).notNull().unique(),
  passwordHash: varchar('password_hash', { length: 255 }).notNull(),
  name: varchar('name', { length: 100 }).notNull(),
  konamiId: varchar('konami_id', { length: 100 }),
  duelingbookUsername: varchar('duelingbook_username', { length: 100 }),
  createdAt: timestamp('created_at').notNull().defaultNow(),
})

export const userCollections = pgTable('user_collections', {
  id: serial('id').primaryKey(),
  userId: integer('user_id').notNull().references(() => users.id),
  name: varchar('name', { length: 255 }).notNull(),
  configured: boolean('configured').notNull().default(false),
  coverImage: varchar('cover_image', { length: 255 }),
  viewMode: varchar('view_mode', { length: 10 }).default('sets'),
  createdAt: timestamp('created_at').notNull().defaultNow(),
})

export const cardSets = pgTable('card_sets', {
  id: serial('id').primaryKey(),
  code: varchar('code', { length: 10 }).notNull(),
  name: varchar('name', { length: 255 }).notNull(),
  orderIndex: integer('order_index').notNull(),
  collectionId: integer('collection_id').references(() => userCollections.id),
})

export const cards = pgTable('cards', {
  id: serial('id').primaryKey(),
  name: varchar('name', { length: 255 }).notNull(),
  nameEn: varchar('name_en', { length: 255 }),
  cardCode: varchar('card_code', { length: 20 }).notNull().unique(),
  setId: integer('set_id').references(() => cardSets.id),
  collectionId: integer('collection_id').references(() => userCollections.id),
  wikiUrl: varchar('wiki_url', { length: 500 }),
  passcode: integer('passcode'),
})

export const collection = pgTable('collection', {
  id: serial('id').primaryKey(),
  cardId: integer('card_id').notNull().references(() => cards.id),
  userId: integer('user_id').notNull().references(() => users.id),
  owned: boolean('owned').notNull().default(false),
  edition: smallint('edition'),
  condition: smallint('condition'),
  isUltimate: boolean('is_ultimate').notNull().default(false),
  language: smallint('language'),
  notes: varchar('notes', { length: 1000 }),
})

export const cardPhotos = pgTable('card_photos', {
  id: serial('id').primaryKey(),
  cardId: integer('card_id').notNull().references(() => cards.id),
  userId: integer('user_id').notNull().references(() => users.id),
  filename: varchar('filename', { length: 255 }).notNull(),
  createdAt: timestamp('created_at').notNull().defaultNow(),
})

export const usersRelations = relations(users, ({ many }) => ({
  collection: many(collection),
  photos: many(cardPhotos),
  userCollections: many(userCollections),
}))

export const userCollectionsRelations = relations(userCollections, ({ one, many }) => ({
  user: one(users, { fields: [userCollections.userId], references: [users.id] }),
  cardSets: many(cardSets),
  directCards: many(cards),
}))

export const cardSetsRelations = relations(cardSets, ({ many, one }) => ({
  cards: many(cards),
  userCollection: one(userCollections, { fields: [cardSets.collectionId], references: [userCollections.id] }),
}))

export const cardsRelations = relations(cards, ({ one, many }) => ({
  cardSet: one(cardSets, { fields: [cards.setId], references: [cardSets.id] }),
  userCollection: one(userCollections, { fields: [cards.collectionId], references: [userCollections.id] }),
  collection: many(collection),
  photos: many(cardPhotos),
}))

export const collectionRelations = relations(collection, ({ one }) => ({
  card: one(cards, { fields: [collection.cardId], references: [cards.id] }),
  user: one(users, { fields: [collection.userId], references: [users.id] }),
}))

export const cardPhotosRelations = relations(cardPhotos, ({ one }) => ({
  card: one(cards, { fields: [cardPhotos.cardId], references: [cards.id] }),
  user: one(users, { fields: [cardPhotos.userId], references: [users.id] }),
}))
