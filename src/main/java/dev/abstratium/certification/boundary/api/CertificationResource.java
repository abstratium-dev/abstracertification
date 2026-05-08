package dev.abstratium.certification.boundary.api;

import org.eclipse.microprofile.openapi.annotations.tags.Tag;

import dev.abstratium.certification.Roles;
import dev.abstratium.certification.entity.Certification;
import dev.abstratium.certification.service.CertificationService;
import jakarta.annotation.security.RolesAllowed;
import jakarta.inject.Inject;
import jakarta.ws.rs.DELETE;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

@Path("/api/certifications")
@Tag(name = "Certifications", description = "Certification management endpoints")
public class CertificationResource {

    @Inject
    CertificationService certificationService;

    @POST
    @Produces(MediaType.APPLICATION_JSON)
    @RolesAllowed({Roles.MANAGE_CERTIFICATIONS})
    public Certification create(Certification certification) {
        return certificationService.create(certification);
    }

    @POST
    @Path("/{id}/replace")
    @Produces(MediaType.APPLICATION_JSON)
    @RolesAllowed({Roles.MANAGE_CERTIFICATIONS})
    public Certification replace(@PathParam("id") String id, Certification certification) {
        return certificationService.replace(id, certification);
    }

    @POST
    @Path("/{id}/copy")
    @Produces(MediaType.APPLICATION_JSON)
    @RolesAllowed({Roles.MANAGE_CERTIFICATIONS})
    public Certification copy(@PathParam("id") String id, CopyRequest request) {
        return certificationService.copy(id, request.newId());
    }

    @DELETE
    @Path("/{id}")
    @RolesAllowed({Roles.MANAGE_CERTIFICATIONS})
    public void delete(@PathParam("id") String id) {
        certificationService.delete(id);
    }

    public record CopyRequest(String newId) {}
}
