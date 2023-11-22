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
    public class PrestamoesController : Controller
    {
        private BibliotecaEntities db = new BibliotecaEntities();

        // GET: Prestamoes
        public ActionResult Index()
        {
            var prestamo = db.Prestamo.Include(p => p.Libro).Include(p => p.Socio);
            return View(prestamo.ToList());
        }

        // GET: Prestamoes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Prestamo prestamo = db.Prestamo.Find(id);
            if (prestamo == null)
            {
                return HttpNotFound();
            }
            return View(prestamo);
        }

        // GET: Prestamoes/Create
        public ActionResult Create()
        {
            ViewBag.IDLibro = new SelectList(db.Libro, "ISBN", "Titulo");
            ViewBag.IDUsuario = new SelectList(db.Socio, "IDUsuario", "Nombre");
            return View();
        }

        // POST: Prestamoes/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "IDPrestamo,IDLibro,IDUsuario,FechaPrestamo,FechaDevolucionPrevista,FechaDevolucionReal,Status,FechaBaja")] Prestamo prestamo)
        {
            if (ModelState.IsValid)
            {
                db.Prestamo.Add(prestamo);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.IDLibro = new SelectList(db.Libro, "ISBN", "Titulo", prestamo.IDLibro);
            ViewBag.IDUsuario = new SelectList(db.Socio, "IDUsuario", "Nombre", prestamo.IDUsuario);
            return View(prestamo);
        }

        // GET: Prestamoes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Prestamo prestamo = db.Prestamo.Find(id);
            if (prestamo == null)
            {
                return HttpNotFound();
            }
            ViewBag.IDLibro = new SelectList(db.Libro, "ISBN", "Titulo", prestamo.IDLibro);
            ViewBag.IDUsuario = new SelectList(db.Socio, "IDUsuario", "Nombre", prestamo.IDUsuario);
            return View(prestamo);
        }

        // POST: Prestamoes/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "IDPrestamo,IDLibro,IDUsuario,FechaPrestamo,FechaDevolucionPrevista,FechaDevolucionReal,Status,FechaBaja")] Prestamo prestamo)
        {
            if (ModelState.IsValid)
            {
                db.Entry(prestamo).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.IDLibro = new SelectList(db.Libro, "ISBN", "Titulo", prestamo.IDLibro);
            ViewBag.IDUsuario = new SelectList(db.Socio, "IDUsuario", "Nombre", prestamo.IDUsuario);
            return View(prestamo);
        }

        // GET: Prestamoes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Prestamo prestamo = db.Prestamo.Find(id);
            if (prestamo == null)
            {
                return HttpNotFound();
            }
            return View(prestamo);
        }

        // POST: Prestamoes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Prestamo prestamo = db.Prestamo.Find(id);
            db.Prestamo.Remove(prestamo);
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
