export function openModal(name, mode='normal') {
  return {
    type: 'OPEN_MODAL',
    name, mode
  }
}

export function closeModal() {
  return {
    type: 'CLOSE_MODAL'
  }
}
