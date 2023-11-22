using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using IEFI_SyO.Models;

namespace IEFI_SyO.Controllers
{
    public class SociosController : Controller
    {
        private BibliotecaEntities db = new BibliotecaEntities();

        // GET: Socios
        public ActionResult Index()
        {
            return View(db.Socio.ToList());
        }

        // GET: Socios/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Socio socio = db.Socio.Find(id);
            if (socio == null)
            {
                return HttpNotFound();
            }
            return View(socio);
        }

        // GET: Socios/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Socios/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "IDUsuario,Nombre,Direccion,Telefono,Correo,LibrosPrestados,FechaBaja")] Socio socio)
        {
            if (ModelState.IsValid)
            {
                db.Socio.Add(socio);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(socio);
        }

        // GET: Socios/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Socio socio = db.Socio.Find(id);
            if (socio == null)
            {
                return HttpNotFound();
            }
            return View(socio);
        }

        // POST: Socios/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "IDUsuario,Nombre,Direccion,Telefono,Correo,LibrosPrestados,FechaBaja")] Socio socio)
        {
            if (ModelState.IsValid)
            {
                db.Entry(socio).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(socio);
        }

        // GET: Socios/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Socio socio = db.Socio.Find(id);
            if (socio == null)
            {
                return HttpNotFound();
            }
            return View(socio);
        }

        // POST: Socios/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Socio socio = db.Socio.Find(id);
            db.Socio.Remove(socio);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
