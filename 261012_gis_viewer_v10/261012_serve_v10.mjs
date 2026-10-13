import http from 'node:http';
import fs from 'node:fs/promises';
import path from 'node:path';
import {fileURLToPath} from 'node:url';

const root=path.resolve(path.dirname(fileURLToPath(import.meta.url)),'261012_publish_v10');
const mime={'.html':'text/html; charset=utf-8','.js':'text/javascript; charset=utf-8','.css':'text/css; charset=utf-8','.json':'application/json','.pbf':'application/vnd.mapbox-vector-tile','.txt':'text/plain; charset=utf-8','.png':'image/png','.svg':'image/svg+xml'};

http.createServer(async(req,res)=>{
 try{
  const requested=decodeURIComponent(new URL(req.url,'http://localhost').pathname);
  const file=path.resolve(root,'.'+(requested==='/'?'/261012_viewer_v10_urbiq.html':requested));
  if(!file.startsWith(root+path.sep)){res.writeHead(403).end();return;}
  const data=await fs.readFile(file);
  res.writeHead(200,{'Content-Type':mime[path.extname(file)]||'application/octet-stream','Access-Control-Allow-Origin':'*','Cache-Control':'no-cache'});
  res.end(data);
 }catch(error){res.writeHead(error.code==='ENOENT'?404:500).end('File unavailable');}
}).listen(8773,'127.0.0.1',()=>console.log('Viewer: http://127.0.0.1:8773/261012_viewer_v10_urbiq.html'));


