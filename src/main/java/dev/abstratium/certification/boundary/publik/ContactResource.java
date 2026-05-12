package dev.abstratium.certification.boundary.publik;

import dev.abstratium.certification.entity.Contact;
import dev.abstratium.certification.service.ContactService;
import dev.abstratium.core.IpAddressUtil;
import dev.abstratium.core.RateLimited;
import io.quarkus.runtime.annotations.RegisterForReflection;
import io.vertx.ext.web.RoutingContext;
import jakarta.inject.Inject;
import jakarta.validation.Valid;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.HttpHeaders;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.eclipse.microprofile.openapi.annotations.tags.Tag;
import org.jboss.logging.Logger;

@Path("/public/contact")
@Tag(name = "Public Contact", description = "Contact form endpoint")
public class ContactResource {

    private static final Logger LOG = Logger.getLogger(ContactResource.class);

    @Inject
    ContactService contactService;

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @RateLimited(maxRequests = 5, windowSeconds = 600)
    public Response submit(@Valid ContactRequest request, @Context HttpHeaders headers, @Context RoutingContext rc) {
        LOG.infof("Contact form submission from email: %s, country: %s", request.getEmail(), request.getCountry());

        String ipAddress = IpAddressUtil.extractIpAddress(headers, rc);

        Contact contact = new Contact();
        contact.setName(request.getName());
        contact.setCountry(request.getCountry());
        contact.setEmail(request.getEmail());
        contact.setQuery(request.getQuery());
        contact.setContext(request.getContext());
        contact.setIpAddress(ipAddress);

        Contact created = contactService.submit(contact);

        return Response.status(Response.Status.CREATED)
                .entity(new ContactResponse(created.getId()))
                .build();
    }

    @RegisterForReflection
    public record ContactResponse(String id) {}
}
