export function openModal(name) {
  return {
    type: 'OPEN_MODAL',
    name
  }
}

export function closeModal() {
  return {
    type: 'CLOSE_MODAL'
  }
}
