import { checkAccessTokenValidity } from "../auth/jwt.utils";

/**
 * MW qui va vérifier si l'utilisateur possède un token d'accès valide et non expiré
 * @param {Request} req - Requête venant de l'utilisateur
 * @param {Response} _ - Réponse inutilisée
 * @param {NextFunction} next - Fonction pour passer au prochain MW 
 */
export default function authMiddleware(req, _, next) {

  const accessToken = req.headers['authorization'];

  if (!accessToken) {
    req.auth = null;
    return next();
  }

  req.auth = checkAccessTokenValidity(accessToken);

  next();

}
