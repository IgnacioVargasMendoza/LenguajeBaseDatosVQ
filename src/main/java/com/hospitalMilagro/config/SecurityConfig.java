package com.hospitalMilagro.config;

import com.hospitalMilagro.domain.Rol;
import com.hospitalMilagro.domain.Usuario;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

@Configuration
public class SecurityConfig implements WebMvcConfigurer {

    @Bean
    public AuthInterceptor authInterceptor() {
        return new AuthInterceptor();
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(authInterceptor())
                .addPathPatterns("/**")
                .excludePathPatterns(
                    "/login/**", 
                    "/registro/**", 
                    "/css/**", 
                    "/js/**", 
                    "/img/**", 
                    "/images/**",
                    "/webjars/**",
                    "/fonts/**",
                    "/favicon.ico"
                );
    }

    public static class AuthInterceptor implements HandlerInterceptor {
        
        // URLs accesibles solo para administradores
        private static final Set<String> ADMIN_PATHS = new HashSet<>(Arrays.asList(
            "/usuario/listado",
            "/usuario/eliminar",
            "/usuario/editar",
            "/especialidades/listado", 
            "/especialidades/eliminar",
            "/especialidades/editar"
        ));
        
        // URLs accesibles solo para doctores y administradores
        private static final Set<String> DOCTOR_ADMIN_PATHS = new HashSet<>(Arrays.asList(
            "/doctor/listado",
            "/doctor/eliminar",
            "/doctor/editar",
            "/citas/listado"
        ));
        
        // URLs accesibles solo para pacientes, doctores y administradores (cada usuario ve sólo sus propias citas)
        private static final Set<String> PATIENT_PATHS = new HashSet<>(Arrays.asList(
            "/paciente/citas",
            "/paciente/agendar-cita"
        ));
        
        @Override
        public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
            String requestURI = request.getRequestURI();
            
            // Permitir acceso a recursos estáticos, login y registro sin autenticación
            if (isPublicResource(requestURI)) {
                return true;
            }
            
            // Verificar si el usuario está autenticado
            HttpSession session = request.getSession(false);
            boolean isAuthenticated = session != null && session.getAttribute("usuario") != null;
            
            if (!isAuthenticated) {
                response.sendRedirect(request.getContextPath() + "/login");
                return false;
            }
            
            // Obtener el usuario y sus roles
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            boolean isAdmin = false;
            boolean isDoctor = false;
            boolean isPaciente = false;
            
            // Verificar roles del usuario
            if (usuario.getRoles() != null) {
                for (Rol rol : usuario.getRoles()) {
                    String rolNombre = rol.getNombreRol();
                    if ("ADMINISTRADOR".equals(rolNombre)) {
                        isAdmin = true;
                    } else if ("DOCTOR".equals(rolNombre)) {
                        isDoctor = true;
                    } else if ("PACIENTE".equals(rolNombre)) {
                        isPaciente = true;
                    }
                }
            }
            
            // Verificar acceso basado en roles
            for (String path : ADMIN_PATHS) {
                if (requestURI.startsWith(path) && !isAdmin) {
                    response.sendRedirect(request.getContextPath() + "/index?error=acceso_denegado");
                    return false;
                }
            }
            
            for (String path : DOCTOR_ADMIN_PATHS) {
                if (requestURI.startsWith(path) && !(isDoctor || isAdmin)) {
                    response.sendRedirect(request.getContextPath() + "/index?error=acceso_denegado");
                    return false;
                }
            }
            
            // Para rutas de pacientes, cualquier rol puede acceder
            // La restricción para ver solo las citas propias se implementará en el controlador
            
            return true;
        }
        
        private boolean isPublicResource(String uri) {
            return uri.startsWith("/login") || 
                   uri.startsWith("/registro") || 
                   uri.startsWith("/css") || 
                   uri.startsWith("/js") || 
                   uri.startsWith("/img") || 
                   uri.startsWith("/images") ||
                   uri.startsWith("/webjars") ||
                   uri.startsWith("/fonts") || 
                   uri.equals("/favicon.ico") ||
                   uri.equals("/") ||
                   uri.equals("/index");
        }
    }
} 