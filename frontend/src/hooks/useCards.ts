import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import { api } from '../api/client'

export function useCollections() {
  return useQuery({
    queryKey: ['collections'],
    queryFn: api.getCollections,
  })
}

export function useCollection(id: number) {
  return useQuery({
    queryKey: ['collections', id],
    queryFn: () => api.getCollection(id),
    enabled: !!id,
  })
}

export function useCollectionAllCards(id: number) {
  return useQuery({
    queryKey: ['collections', id, 'all-cards'],
    queryFn: () => api.getCollectionAllCards(id),
    enabled: !!id,
  })
}

export function useCreateCollection() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (name: string) => api.createCollection(name),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['collections'] })
    },
  })
}

export function useDeleteCollection() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, password }: { id: number; password: string }) => api.deleteCollection(id, password),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['collections'] })
    },
  })
}

export function useUploadCollectionCover(collectionId: number) {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (file: File) => api.uploadCollectionCover(collectionId, file),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['collections'] })
      queryClient.invalidateQueries({ queryKey: ['collections', collectionId] })
    },
  })
}

export function useCardDetail(cardId: number) {
  return useQuery({
    queryKey: ['cards', cardId],
    queryFn: () => api.getCard(cardId),
    enabled: !!cardId,
  })
}


export function useSets(collectionId?: number) {
  return useQuery({
    queryKey: ['sets', collectionId],
    queryFn: () => api.getSets(collectionId),
  })
}

export function useSetCards(setCode: string) {
  return useQuery({
    queryKey: ['sets', setCode, 'cards'],
    queryFn: () => api.getSetCards(setCode),
    enabled: !!setCode,
  })
}

export function useStats(collectionId?: number) {
  return useQuery({
    queryKey: ['stats', collectionId],
    queryFn: () => api.getStats(collectionId),
  })
}

export function useUpdateCollection(setCode: string) {
  const queryClient = useQueryClient()

  return useMutation({
    mutationFn: ({
      cardId, owned, edition, condition, isUltimate, language, notes,
    }: { cardId: number; owned: boolean; edition: number | null; condition: number | null; isUltimate: boolean; language?: number | null; notes?: string | null }) =>
      api.updateCollection(cardId, { owned, edition, condition, isUltimate, language, notes }),
    onSettled: (_data, _err, vars) => {
      queryClient.invalidateQueries({ queryKey: ['cards', vars.cardId] })
      queryClient.invalidateQueries({ queryKey: ['sets', setCode, 'cards'] })
      queryClient.invalidateQueries({ queryKey: ['sets'] })
      queryClient.invalidateQueries({ queryKey: ['stats'] })
      queryClient.invalidateQueries({ queryKey: ['collections'] })
    },
  })
}

export function useUpdateCardDetail(cardId: number) {
  const queryClient = useQueryClient()

  return useMutation({
    mutationFn: (data: { owned: boolean; edition: number | null; condition: number | null; isUltimate: boolean; language?: number | null; notes?: string | null }) =>
      api.updateCollection(cardId, data),
    onSettled: () => {
      queryClient.invalidateQueries({ queryKey: ['cards', cardId] })
      queryClient.invalidateQueries({ queryKey: ['sets'] })
      queryClient.invalidateQueries({ queryKey: ['stats'] })
    },
  })
}

export function useUploadPhoto(setCode: string) {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ cardId, file }: { cardId: number; file: File }) =>
      api.uploadPhoto(cardId, file),
    onSuccess: (_data, vars) => {
      queryClient.invalidateQueries({ queryKey: ['sets', setCode, 'cards'] })
      queryClient.invalidateQueries({ queryKey: ['cards', vars.cardId] })
    },
  })
}

export function useDeletePhoto(setCode: string) {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ cardId, photoId }: { cardId: number; photoId: number }) =>
      api.deletePhoto(cardId, photoId),
    onSuccess: (_data, vars) => {
      queryClient.invalidateQueries({ queryKey: ['sets', setCode, 'cards'] })
      queryClient.invalidateQueries({ queryKey: ['cards', vars.cardId] })
    },
  })
}

export function useUploadPhotoForCard(cardId: number) {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (file: File) => api.uploadPhoto(cardId, file),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['cards', cardId] })
      queryClient.invalidateQueries({ queryKey: ['sets'] })
    },
  })
}

export function useDeletePhotoForCard(cardId: number) {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (photoId: number) => api.deletePhoto(cardId, photoId),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['cards', cardId] })
      queryClient.invalidateQueries({ queryKey: ['sets'] })
    },
  })
}
