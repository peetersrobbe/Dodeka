import uvicorn
from fastapi import FastAPI, Request, Form
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates


app = FastAPI()

templates = Jinja2Templates(directory="Templates")
app.mount("/static", StaticFiles(directory="static", name = "static"))

@app.get('/basic', response_class=HTMLResponse)
def get_basic_form(request: Request):
    return templates.TemplateResponse("contact.html", {"request": request})

@app.post('/basic', response_class=HTMLResponse)
def post_basic_form(request: Request, name: str = Form(...), email: str = Form(...)):
    print(f'name: {name}')
    print(f'email: {email}')
    return templates.TemplateResponse("contact.html", {"request": request})

if __name__ == '__main__':
    uvicorn.run(app)