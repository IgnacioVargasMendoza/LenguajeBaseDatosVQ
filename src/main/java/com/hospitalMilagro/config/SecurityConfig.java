package com.hospitalMilagro.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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
                   uri.equals("/favicon.ico");
        }
    }
} 