var lastheights = []

function getH(cpu) {
  return lastheights[cpu]
}
function maxH(cpu) {
  return Math.max.apply(null, lastheights[cpu])
}
function addH(cpu, value) {
  if (!lastheights[cpu])
    lastheights[cpu] = []
  if (lastheights[cpu].push(value) > 6)
    lastheights[cpu].shift()
}
