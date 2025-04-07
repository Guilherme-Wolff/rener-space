
const express = require('express');


const diskInfo = require('node-disk-info');

const app = express();
const PORT = process.env.PORT || 3002;

app.get('/info', async (req, res) => {
    try {
        // Obter informações de todos os discos
        const disks = await diskInfo.getDiskInfo();
        
        // Encontrar o disco principal (geralmente o disco onde está o sistema)
        const mainDisk = disks.find(disk => disk.mounted === '/') || disks[0];
        
        // Calcular espaço total, usado e livre em GB
        const totalGB = (mainDisk.blocks / (1024 * 1024 * 1024)).toFixed(2);
        const usedGB = (mainDisk.used / (1024 * 1024 * 1024)).toFixed(2);
        const freeGB = (mainDisk.available / (1024 * 1024 * 1024)).toFixed(2);
        
        res.send({
          space: {
            total: `${totalGB} GB`,
            used: `${usedGB} GB`,
            free: `${freeGB} GB`,
            percentUsed: `${mainDisk.capacity}`
          }
        });
      } catch (error) {
        console.error('Erro ao obter informações de disco:', error);
        res.status(500).send({
          space: 'Erro ao obter informações do disco',
          error: error.message
        });
      }
});

app.listen(PORT, () => {
  console.log(`Servidor rodando em http://localhost:${PORT}`);
});